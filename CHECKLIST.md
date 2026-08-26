# CHECKLIST.md — Launch Checklist

Everything that must be true before the page goes public. Sources: REQUIREMENTS.md (R) and DESIGN.md (D). Development may proceed with placeholders; **launch is blocked until every box is ticked.**

## Content

- [ ] Final PT-PT copy adapted from Adriana's profile text (the PDF), AO90, and **approved by Adriana** (R P-9) — drafted, awaiting her approval
- [x] Page `<title>` and meta description written in PT-PT, naming explicações, subjects, and Porto/Paranhos (R Q-3)
- [ ] Pre-filled WhatsApp message text written and approved (R P-8) — written, awaiting her approval
- [x] "Resposta em 24 horas" appears next to both contact actions (R P-8)
- [x] Prices shown: 15 €/hora + free first lesson; no packs anywhere; "passa recibo" stated next to the price (R P-6)
- [x] No mention of online lessons anywhere (R §1, P-7)

## Assets

- [ ] Placeholder photo replaced with Adriana's real photograph, with her consent (R P-4)
- [x] Share-preview (Open Graph) image produced with name/offer — text graphic at `public/og-image.png` (R Q-6)
- [x] Favicon set (both colourways, theme-aware SVG) committed under `public/` and referenced from the page (D §6)

## Contact & secrets

- [ ] WhatsApp number and email stored as GitHub secrets; injected at deploy; **never present in the repository or its history** (R §7)
- [x] Anti-scraping reveal verified: contact data absent from raw page source/snippets, revealed only on deliberate action (R P-8) — enforced by `build.sh` on every build
- [ ] Contact reveal fully operable by keyboard and screen reader (D §8) — keyboard verified (Tab + Enter reaches WhatsApp); screen-reader pass outstanding
- [ ] Both contact paths tested end-to-end on a real phone: WhatsApp opens with the pre-filled message; email link works

## Accessibility (R Q-5, D §8)

- [x] Automated accessibility audit passes clean — `pa11y-ci` (axe + htmlcs, WCAG2AA), 0 errors, and in CI on every push
- [ ] Manual keyboard-only walkthrough reaches WhatsApp contact end-to-end — passes under simulated keyboard input; still needs a human pass
- [ ] Screen-reader walkthrough (PT-PT announced correctly) reaches WhatsApp contact end-to-end
- [x] All text/background pairs measured and pass WCAG 2.2 AA; WhatsApp button label ≥18 px semibold — measured; label is 19 px/700, which white-on-`--cta-whatsapp` (4.14:1) requires
- [x] Usable at 200 % zoom and 320 px viewport; `prefers-reduced-motion` respected — no horizontal scrolling at 320/360/640 px; the page declares no motion at all

## Design acceptance (D §10)

- [x] 360 px first-screen check: name, offer, levels, Paranhos/Porto, WhatsApp button — nothing competing
- [x] Greyscale screenshot: hierarchy still reads; CTA most prominent
- [x] Squint test: one eye-catching element per screenful
- [x] Nothing on the page moves uninitiated — the stylesheet declares no transition, animation or smooth scrolling

## Compliance & final

- [x] Zero cookies, zero analytics, zero third-party identifier-setting embeds — verified in the network panel; no consent UI present (R Q-4) — the built output references no third-party host at all; fonts are self-hosted
- [ ] Domain recorded and connected; page served over HTTPS
- [ ] 30-second test with a fresh reader on a phone: can they answer _what, for which years, where, price, how to contact?_ (R §8)
