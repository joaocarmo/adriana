/* Contact reveal (REQUIREMENTS P-8).
 *
 * Details are injected at build time, reversed then base64-encoded, so they are
 * not harvestable from the page source. Buttons ship disabled: without working
 * JavaScript a visitor gets an inert control and the <noscript> note, rather
 * than a call to action that silently does nothing.
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
