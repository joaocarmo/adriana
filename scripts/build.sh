#!/usr/bin/env bash
#
# Build into dist/: copy public/, inject the contact details and the private
# photograph, then verify none of it leaked into the output.
#
#   WHATSAPP_NUMBER=351900000000 CONTACT_EMAIL=exemplo@exemplo.pt ./scripts/build.sh
#
# WHATSAPP_NUMBER, CONTACT_EMAIL and ASSETS_KEY are required — shipping a
# stand-in number or face is worse than failing to build. SITE_URL is optional
# and only affects the share preview.

set -euo pipefail
cd "$(dirname "$0")/.."

SRC=public
OUT=dist

PHOTO_SRC=photo.jpg
PHOTO_ALT="Adriana, explicadora, a sorrir para a câmara."

fail() { echo "error: $*" >&2; exit 1; }

# .env supplies locally what CI gets from secrets. The environment wins over it.

if [ -f .env ]; then
  while IFS= read -r line || [ -n "$line" ]; do
    case "$line" in ''|'#'*|*!*) continue ;; esac
    case "$line" in *=*) ;; *) continue ;; esac
    # Split by hand: `read -r key value` with IFS='=' swallows the trailing
    # '=' of a base64 value such as ASSETS_KEY.
    key=${line%%=*}
    value=${line#*=}
    [ -n "${!key:-}" ] || export "$key=$value"
  done < .env
fi

# --- validate inputs: they arrive from CI secrets, so check rather than trust

[ -n "${WHATSAPP_NUMBER:-}" ] || fail "WHATSAPP_NUMBER is not set"
[ -n "${CONTACT_EMAIL:-}" ] || fail "CONTACT_EMAIL is not set"

# wa.me wants digits only: no +, no spaces, country code included.
WHATSAPP_DIGITS=$(printf '%s' "$WHATSAPP_NUMBER" | tr -cd '0-9')
case ${#WHATSAPP_DIGITS} in
  8|9|10|11|12|13|14|15) ;;
  *) fail "WHATSAPP_NUMBER must hold 8-15 digits including the country code" ;;
esac

case "$CONTACT_EMAIL" in
  *@*.*) ;;
  *) fail "CONTACT_EMAIL does not look like an e-mail address" ;;
esac

if [ -z "${SITE_URL:-}" ]; then
  SITE_URL="http://localhost:8000"
  echo "warning: SITE_URL is not set, using $SITE_URL (share previews will be wrong)" >&2
fi
SITE_URL=${SITE_URL%/}

# --- assemble dist/

rm -rf "$OUT"
cp -R "$SRC" "$OUT"

# Private assets are committed encrypted; decrypt whatever is there.
shopt -s nullglob
for encrypted in assets/*.enc; do
  [ -n "${ASSETS_KEY:-}" ] || fail "assets/ holds encrypted files but ASSETS_KEY is not set"
  name=$(basename "${encrypted%.enc}")
  ./scripts/assets.sh decrypt "$encrypted" "$OUT/$name"
  echo "decrypted $name"
done
shopt -u nullglob

# Required, with no placeholder to fall back to: failing beats publishing a
# stand-in where her face belongs (REQUIREMENTS P-4).
[ -f "$OUT/$PHOTO_SRC" ] || fail "$PHOTO_SRC is missing — expected assets/$PHOTO_SRC.enc to decrypt into $OUT"

# --- inject: reversed and base64-encoded, so the details are not readable in
# the served source (REQUIREMENTS P-8).

# `rev` terminates its output with a newline, which would survive base64 and
# reappear inside the decoded number, so strip it.
encode() { printf '%s' "$1" | rev | tr -d '\n' | base64 | tr -d '\n'; }
decode() { printf '%s' "$1" | base64 -d | rev | tr -d '\n'; }

WHATSAPP_ENC=$(encode "$WHATSAPP_DIGITS")
EMAIL_ENC=$(encode "$CONTACT_EMAIL")

[ "$(decode "$WHATSAPP_ENC")" = "$WHATSAPP_DIGITS" ] || fail "WhatsApp number does not survive encoding"
[ "$(decode "$EMAIL_ENC")" = "$CONTACT_EMAIL" ] || fail "e-mail address does not survive encoding"

# sed uses | as its delimiter below, so no injected value may contain one.
for value in "$SITE_URL" "$PHOTO_SRC" "$PHOTO_ALT" "$WHATSAPP_ENC" "$EMAIL_ENC"; do
  case "$value" in *"|"*) fail "injected values must not contain a '|' character" ;; esac
done

sed -i.bak \
  -e "s|__SITE_URL__|$SITE_URL|g" \
  -e "s|__PHOTO_SRC__|$PHOTO_SRC|g" \
  -e "s|__PHOTO_ALT__|$PHOTO_ALT|g" \
  "$OUT/index.html"

sed -i.bak \
  -e "s|__WHATSAPP_ENC__|$WHATSAPP_ENC|g" \
  -e "s|__EMAIL_ENC__|$EMAIL_ENC|g" \
  "$OUT/contact.js"

rm -f "$OUT"/*.bak

# --- verify: the check that must never regress.

if grep -rqF -- "$CONTACT_EMAIL" "$OUT" \
  || grep -rqF -- "$WHATSAPP_DIGITS" "$OUT" \
  || grep -rqF -- "$WHATSAPP_NUMBER" "$OUT"; then
  fail "contact details are readable in $OUT — the anti-scraping injection is broken"
fi

if grep -rqE '__[A-Z_]+__' "$OUT"; then
  fail "unreplaced __TOKEN__ placeholders remain in $OUT"
fi

echo "built $OUT ($(find "$OUT" -type f | wc -l | tr -d ' ') files)"
