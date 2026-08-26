/* Contact reveal (REQUIREMENTS P-8).
 *
 * The number and the address are injected at build time, reversed and then
 * base64-encoded, so neither appears as machine-readable text in the page
 * source or in a search snippet. A visitor still reaches Adriana in one tap:
 * the button decodes the value and navigates straight to WhatsApp or the mail
 * client. Buttons ship disabled and are enabled here, so a page without
 * working JavaScript shows an inert control plus the <noscript> explanation
 * rather than a call to action that silently does nothing.
 */
(function () {
  'use strict';

  var ENCODED = {
    whatsapp: '__WHATSAPP_ENC__',
    email: '__EMAIL_ENC__'
  };

  var WHATSAPP_MESSAGE =
    'Olá, Adriana! Encontrei o seu site e gostaria de saber mais sobre as explicações.';
  var EMAIL_SUBJECT = 'Explicações — pedido de informação';

  function decode(value) {
    return atob(value).split('').reverse().join('');
  }

  function destination(kind) {
    var value = decode(ENCODED[kind]);
    if (kind === 'whatsapp') {
      return 'https://wa.me/' + value + '?text=' + encodeURIComponent(WHATSAPP_MESSAGE);
    }
    return 'mailto:' + value + '?subject=' + encodeURIComponent(EMAIL_SUBJECT);
  }

  function activate(button) {
    button.addEventListener('click', function () {
      window.location.href = destination(button.dataset.contact);
    });
    button.disabled = false;
  }

  Array.prototype.forEach.call(document.querySelectorAll('[data-contact]'), activate);
})();
