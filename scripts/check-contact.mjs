/*
 * Runs the built contact.js against a stub DOM and asserts that both buttons
 * end up pointing at the real contact details.
 *
 *   WHATSAPP_NUMBER=... CONTACT_EMAIL=... node scripts/check-contact.mjs
 *
 * The page has exactly one piece of logic and this is it: if the decoding ever
 * breaks, the only call to action on the page silently stops working. A stub
 * is used because a headless browser cannot observe a mailto: navigation.
 */
import assert from 'node:assert/strict';
import fs from 'node:fs';
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
