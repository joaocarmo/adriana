#!/usr/bin/env bash
#
# Encrypt private assets (Adriana's photograph) so they can live in a public
# repository, and decrypt them again at build time. The passphrase is never
# committed — it lives in the ASSETS_KEY GitHub secret.
#
#   Generate a key once:  openssl rand -base64 32
#   Encrypt:              ASSETS_KEY=... ./scripts/assets.sh encrypt ~/photo.jpg photo.jpg
#   Decrypt (build.sh):   ASSETS_KEY=... ./scripts/assets.sh decrypt assets/photo.jpg.enc dist/photo.jpg
#
# The encrypted blob is committed; the plaintext never is.

set -euo pipefail

# Shared by both directions — they must match, so they are declared once.
CIPHER=(-aes-256-cbc -pbkdf2 -iter 600000 -salt -pass env:ASSETS_KEY)

usage() {
  echo "usage: $0 encrypt <source-file> <name>" >&2
  echo "       $0 decrypt <encrypted-file> <destination>" >&2
  exit 2
}

require_key() {
  if [ -z "${ASSETS_KEY:-}" ]; then
    echo "error: ASSETS_KEY is not set" >&2
    exit 1
  fi
}

[ $# -eq 3 ] || usage
require_key

case "$1" in
  encrypt)
    [ -f "$2" ] || { echo "error: no such file: $2" >&2; exit 1; }
    mkdir -p assets
    openssl enc "${CIPHER[@]}" -in "$2" -out "assets/$3.enc"
    echo "wrote assets/$3.enc — commit this; never commit $2"
    ;;
  decrypt)
    [ -f "$2" ] || { echo "error: no such file: $2" >&2; exit 1; }
    openssl enc -d "${CIPHER[@]}" -in "$2" -out "$3"
    ;;
  *)
    usage
    ;;
esac
