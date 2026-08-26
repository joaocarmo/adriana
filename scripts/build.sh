#!/usr/bin/env bash
#
# Build the site into dist/: copy the sources, inject the contact details and
# the private photograph, then verify that none of it leaked into the output.
#
#   WHATSAPP_NUMBER=351900000000 CONTACT_EMAIL=exemplo@exemplo.pt ./scripts/build.sh
#
# WHATSAPP_NUMBER and CONTACT_EMAIL are required: a page that ships with a
# placeholder number is worse than a page that fails to build.
# SITE_URL is optional and only affects the share preview.
# ASSETS_KEY is required only when assets/*.enc are present.

set -euo pipefail
cd "$(dirname "$0")/.."

SRC=public
OUT=dist

PLACEHOLDER_SRC=photo-placeholder.svg
PLACEHOLDER_ALT="Fotografia provisória, a substituir pela fotografia da Adriana antes do lançamento."
PHOTO_ALT="Adriana, explicadora, na sala de estudo onde dá as aulas."

fail() { echo "error: $*" >&2; exit 1; }

# --- validate inputs (they come from CI secrets, so check them, don't trust them)

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

if [ -f "$OUT/photo.jpg" ]; then
  PHOTO_SRC=photo.jpg
  PHOTO_LABEL=$PHOTO_ALT
else
  PHOTO_SRC=$PLACEHOLDER_SRC
  PHOTO_LABEL=$PLACEHOLDER_ALT
  echo "warning: using the placeholder photograph — not fit to launch (REQUIREMENTS P-4)" >&2
fi

# --- inject
#
# Contact details go in reversed and base64-encoded so they are not readable as
# plain text in the served source (REQUIREMENTS P-8).

# `rev` terminates its output with a newline, which would survive base64 and
# reappear inside the decoded number, so strip it.
encode() { printf '%s' "$1" | rev | tr -d '\n' | base64 | tr -d '\n'; }
decode() { printf '%s' "$1" | base64 -d | rev | tr -d '\n'; }

WHATSAPP_ENC=$(encode "$WHATSAPP_DIGITS")
EMAIL_ENC=$(encode "$CONTACT_EMAIL")

# The page is worthless if these do not survive the round trip.
[ "$(decode "$WHATSAPP_ENC")" = "$WHATSAPP_DIGITS" ] || fail "WhatsApp number does not survive encoding"
[ "$(decode "$EMAIL_ENC")" = "$CONTACT_EMAIL" ] || fail "e-mail address does not survive encoding"

# sed uses | as its delimiter below, so no injected value may contain one.
for value in "$SITE_URL" "$PHOTO_SRC" "$PHOTO_LABEL" "$WHATSAPP_ENC" "$EMAIL_ENC"; do
  case "$value" in *"|"*) fail "injected values must not contain a '|' character" ;; esac
done

sed -i.bak \
  -e "s|__SITE_URL__|$SITE_URL|g" \
  -e "s|__PHOTO_SRC__|$PHOTO_SRC|g" \
  -e "s|__PHOTO_ALT__|$PHOTO_LABEL|g" \
  "$OUT/index.html"

sed -i.bak \
  -e "s|__WHATSAPP_ENC__|$WHATSAPP_ENC|g" \
  -e "s|__EMAIL_ENC__|$EMAIL_ENC|g" \
  "$OUT/contact.js"

rm -f "$OUT"/*.bak

# --- verify the output
#
# This is the check that must never regress: the contact details are the whole
# point of the page and must not be harvestable from it.

if grep -rqF -- "$CONTACT_EMAIL" "$OUT" \
  || grep -rqF -- "$WHATSAPP_DIGITS" "$OUT" \
  || grep -rqF -- "$WHATSAPP_NUMBER" "$OUT"; then
  fail "contact details are readable in $OUT — the anti-scraping injection is broken"
fi

if grep -rqE '__[A-Z_]+__' "$OUT"; then
  fail "unreplaced __TOKEN__ placeholders remain in $OUT"
fi

echo "built $OUT ($(find "$OUT" -type f | wc -l | tr -d ' ') files)"
