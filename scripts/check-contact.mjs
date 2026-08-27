/*
 * Asserts that both buttons resolve to the real contact details, and that those
 * details are readable nowhere in dist/.
 *
 *   WHATSAPP_NUMBER=... CONTACT_EMAIL=... node scripts/check-contact.mjs
 *
 * build.sh checks the leak independently — keep both, so neither is ever the
 * only guard. Uses a stub DOM: a headless browser cannot observe mailto:.
 */
import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import vm from 'node:vm';

const number = (process.env.WHATSAPP_NUMBER ?? '').replace(/\D/g, '');
const email = process.env.CONTACT_EMAIL ?? '';
assert.ok(number && email, 'set WHATSAPP_NUMBER and CONTACT_EMAIL');

const source = fs.readFileSync('dist/contact.js', 'utf8');
assert.ok(!source.includes('__'), 'contact.js still holds unreplaced build tokens');

const buttons = ['whatsapp', 'email'].map((kind) => ({
  dataset: { contact: kind },
  disabled: true,
  addEventListener(type, handler) {
    assert.equal(type, 'click');
    this.fire = handler;
  },
}));

let destination = null;
vm.runInContext(source, vm.createContext({
  document: { querySelectorAll: () => buttons },
  window: { location: { set href(value) { destination = value; } } },
  atob: (value) => Buffer.from(value, 'base64').toString('binary'),
}));

const [whatsapp, mail] = buttons;

assert.ok(!whatsapp.disabled && !mail.disabled, 'buttons were not enabled');

whatsapp.fire();
assert.equal(
  destination,
  `https://wa.me/${number}?text=${encodeURIComponent(
    'Olá, Adriana! Encontrei o seu site e gostaria de saber mais sobre as explicações.')}`,
  'WhatsApp link is wrong',
);

mail.fire();
assert.equal(
  destination,
  `mailto:${email}?subject=${encodeURIComponent('Explicações — pedido de informação')}`,
  'e-mail link is wrong',
);

console.log('contact links resolve correctly for both channels');

// Raw number, digits-only form, and address must all be absent.
const secrets = [process.env.WHATSAPP_NUMBER, number, email].filter(Boolean);
const files = fs.readdirSync('dist', { recursive: true, withFileTypes: true })
  .filter((entry) => entry.isFile())
  .map((entry) => path.join(entry.parentPath ?? entry.path, entry.name));

for (const file of files) {
  const content = fs.readFileSync(file);
  for (const secret of secrets) {
    assert.equal(
      content.includes(secret), false,
      `contact details are readable in ${file} — the anti-scraping injection is broken`,
    );
  }
}

console.log(`contact details are not readable in any of the ${files.length} built files`);
