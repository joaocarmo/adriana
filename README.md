# adriana

Single-page site for Adriana, explicadora in Porto (Paranhos): in-person
explicações in Português, Inglês and Francês for the 2.º and 3.º ciclos.

See [requirements] and [design] for what the page must say and how it must
look; [checklist] lists everything that has to be true before it goes public.

## How it is built

Hand-written HTML, CSS and about thirty lines of JavaScript. No framework, no
build tool, no npm dependencies in the repository — `scripts/build.sh` copies
`public/` to `dist/` and substitutes a handful of values. CI installs
`html-validate` and `pa11y-ci` on the fly to check the result.

```
public/            the site itself; edit these files
scripts/build.sh   builds dist/, then verifies it
scripts/assets.sh  encrypts/decrypts Adriana's photograph
.github/workflows  builds and checks every push; deploys main to GitHub Pages
```

## Local preview

```sh
cp .env.example .env    # first time only, then fill in ASSETS_KEY
npm start               # builds and serves on http://localhost:8000
```

`package.json` declares no dependencies — it only names the commands:

| Command             | What it does                                       |
| ------------------- | -------------------------------------------------- |
| `npm run build`     | builds `dist/` and verifies it                     |
| `npm start`         | builds, then serves `dist/` on port 8000           |
| `npm run serve`     | serves on the LAN too, for testing on a real phone |
| `npm test`          | build plus all three checks                        |
| `npm run check`     | contact links, HTML validity, accessibility        |

`build.sh` reads `.env` if it is there, so the plain `./scripts/build.sh` works
the same way. Anything already exported wins over `.env`, and CI — which has no
`.env` — is unaffected.

The contact details are required either way: the build fails rather than ship a
placeholder number, which is why `.env` carries obvious dummies.

## Deployment

Pushing to `main` builds, checks and publishes to GitHub Pages. Repository
settings → Pages → Source must be set to **GitHub Actions**.

Required secrets (Settings → Secrets and variables → Actions):

| Secret            | Value                                                          |
| ----------------- | -------------------------------------------------------------- |
| `WHATSAPP_NUMBER` | international format, e.g. `351912345678` (digits only is safest) |
| `CONTACT_EMAIL`   | her e-mail address                                             |
| `ASSETS_KEY`      | passphrase for the encrypted photograph — `openssl rand -base64 32` |

Optional variable `SITE_URL` (e.g. `https://exemplo.pt`) sets the canonical and
share-preview URLs; without it the GitHub Pages URL is used. Set it once the
domain is connected, and add a `public/CNAME` file containing the domain.

## Updating the page

- **Prices, hours, copy:** edit `public/index.html`. The prices live in the
  `Preços` section and appear nowhere else.
- **Adriana's photograph:** already in place as `assets/photo.jpg.enc`. The
  build decrypts it to `photo.jpg` and switches the `<img>` over automatically,
  alt text included; the plaintext is never committed. To replace it:

  ```sh
  ./scripts/assets.sh encrypt ~/path/to/new-photo.jpg photo.jpg
  ```

  Crop it square first — it is displayed at 180–220 px, so about 440 × 440 is
  plenty. Because `assets/` is no longer empty, **a build without `ASSETS_KEY`
  now fails** rather than quietly falling back to the placeholder.
- **Icons:** the icon set under `public/` is committed. It was generated once
  with a local script (`generate_favicon.py`, deliberately not in the repo)
  from Nunito Sans Bold, in both colourways.

## Why the contact details work the way they do

Her number and address are never in the repository. They are injected at build
time, reversed and base64-encoded, so they do not appear as readable text in
the page source or in a search snippet — a bot scraping the HTML finds nothing
to harvest, while a parent still reaches her in one tap. `build.sh` fails the
build if either value can be found in the output, and `check-contact.mjs`
asserts that both buttons still resolve to the right destination.

Consequence: the buttons need JavaScript. They ship disabled and are enabled by
`contact.js`, with a `<noscript>` note explaining why, so the page never shows a
call to action that silently does nothing.

## Checks

```sh
npm test                 # build, then all three checks below
npm run check:contact    # both contact links resolve to the right destination
npm run check:html       # markup validity
npm run check:a11y       # axe + HTML_CodeSniffer at WCAG2AA, against a served dist/
```

Automated checks do not prove accessibility on their own: the manual
keyboard-only and screen-reader walkthroughs in [checklist] are part of launch.

<!-- References -->

[requirements]: REQUIREMENTS.md
[design]: DESIGN.md
[checklist]: CHECKLIST.md
