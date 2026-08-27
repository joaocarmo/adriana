# adriana

Single-page site for Adriana, explicadora in Porto: in-person explicações in
Português, Inglês and Francês for the 2.º and 3.º ciclos.

Hand-written HTML, CSS and a little JavaScript. No framework, no runtime
dependencies. `scripts/build.sh` copies `public/` to `dist/` and substitutes a
few values.

- [REQUIREMENTS.md](REQUIREMENTS.md) — what the page must say
- [DESIGN.md](DESIGN.md) — how it must look
- [CHECKLIST.md](CHECKLIST.md) — what must be true before it goes public

## Getting started

```sh
nvm use                 # Node version from .nvmrc
cp .env.example .env    # then fill in the values
npm start               # build and serve on http://localhost:8000
```

| Command         | What it does                                       |
| --------------- | -------------------------------------------------- |
| `npm run build` | builds `dist/` and verifies it                     |
| `npm start`     | builds, then serves `dist/`                        |
| `npm run serve` | serves on the LAN too, for testing on a phone      |
| `npm test`      | build plus the checks below                        |
| `npm run check` | contact links, HTML validity, accessibility        |

The build requires the contact details to be set and fails without them, rather
than shipping a placeholder. `.env` supplies them locally; anything already
exported wins over it.

## Editing

Prices, hours and copy live in `public/index.html`. Adriana's photograph is
committed encrypted and decrypted at build time — see `scripts/assets.sh`.

`public/robots.txt` and `public/llms.txt` are plain static files, copied as-is.
Keep `llms.txt` free of prices, hours and contact details: it is a second copy of
the facts, and a stale one is worse than none.

There is no code formatter, deliberately: `.editorconfig` covers whitespace,
and Prettier's output fails this repo's own HTML validation.

## Deploying

Pushing to `main` builds, checks and publishes to GitHub Pages. Everything
environment-specific — secrets, the site URL, DNS — is configured in the
repository settings, not here.

## Licence

The repository is public because GitHub Pages serves free sites only from
public repositories, not as an invitation to reuse what is in it. The code is
MIT; the site content is Adriana's, all rights reserved. See [LICENSE](LICENSE).
