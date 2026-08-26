# DESIGN.md — Design Guidelines for Adriana's Explicações Page

Companion to REQUIREMENTS.md. Requirements define _what_ the page says; this document defines _how it looks and feels_. Where the two conflict, REQUIREMENTS.md wins.

## 1. Design intent

**Simple, clean, uncluttered, professional — with a warm, approachable temperature.** The visitor is a parent, usually on a phone, deciding whether to trust a stranger with their child's schooling. The design's job is to make the page feel like Adriana herself: organised, calm, and warm. Nothing on the page should feel like marketing.

Every design decision is tested against one question: **does removing this make the page clearer?** If yes, remove it.

## 2. Principles

1. **One column, one path.** A single reading flow from value proposition to contact (P-2 → P-8). No sidebars, no competing layouts, no carousels.
2. **Whitespace is the design.** Generosity of space, not decoration, is what makes the page feel professional. When in doubt, add space, not elements.
3. **One accent colour, used sparingly.** Colour marks what matters (the contact action, key facts). If everything is highlighted, nothing is.
4. **Warmth comes from tone, type, and palette — not ornament.** No illustrations scattered around, no decorative shapes, no stock photography (REQUIREMENTS P-4: the only photo on the page is Adriana's).
5. **Calm.** No motion the visitor didn't ask for. Nothing pops up, slides in, or autoplays.

## 3. Colour

Single light theme. No dark mode — one deliberate look, consistently executed.

| Token             | Value     | Use                                                     |
| ----------------- | --------- | ------------------------------------------------------- |
| `--bg`            | `#FAF6F1` | Page background — warm off-white ("paper")              |
| `--surface`       | `#FFFFFF` | Cards/blocks that need gentle separation                |
| `--ink`           | `#2B2420` | Headings and body text — warm near-black                |
| `--ink-soft`      | `#6B5F55` | Secondary text (captions, conditions)                   |
| `--accent`        | `#9C4A2F` | Terracotta — links, highlights, accent text             |
| `--accent-strong` | `#83402A` | Hover/pressed state of accent                           |
| `--accent-soft`   | `#F3E4DA` | Tinted backgrounds (e.g. the pricing block)             |
| `--cta-whatsapp`  | `#128C7E` | WhatsApp button only — recognisable WhatsApp teal-green |

Rules: the accent appears in, at most, one element per screenful. The WhatsApp green is reserved exclusively for the WhatsApp button (P-8) — its recognisability is functional, not decorative. All text/background pairs must pass WCAG AA (4.5:1 body, 3:1 large text); the values above were chosen to pass but must be verified at implementation, especially white-on-`--cta-whatsapp`, which passes only at large-text size — the button label must be ≥18 px semibold.

## 4. Typography

One typeface family for everything: **Nunito Sans** (or a similar warm humanist sans), weights 400 and 700 only. Fallback: the system sans-serif stack. Full support for Portuguese diacritics is mandatory (ã, ç, é, ê, õ…).

| Role                   | Mobile       | Desktop     | Notes             |
| ---------------------- | ------------ | ----------- | ----------------- |
| H1 (value proposition) | 28 px / 1.25 | 36 px / 1.2 | Bold; the only H1 |
| H2 (section titles)    | 22 px / 1.3  | 26 px / 1.3 | Bold              |
| Body                   | 17 px / 1.6  | 18 px / 1.6 | Regular           |
| Secondary/small        | 14 px / 1.5  | 15 px / 1.5 | `--ink-soft`      |

Line length capped at ~65 characters. No italics for emphasis (bold or accent colour instead), no ALL CAPS except possibly short labels, no letter-spacing tricks. Prices (15 €/hora) and the free first lesson are set in body sizes with bold/accent — never in oversized "sale" typography.

## 5. Layout & spacing

- **Mobile-first, single column.** Content column max-width ~44 rem (≈700 px), centred; the page never needs horizontal scrolling.
- **Spacing scale:** multiples of 8 px. Section vertical padding: 48 px mobile, 72 px desktop. Related items 8–16 px apart; unrelated sections separated by space, not by lines or boxes.
- **Section order is fixed** by REQUIREMENTS §5 (P-2 → P-9). Each section is one idea; no section needs more than one screen on mobile.
- **Separation by rhythm, not chrome.** Prefer whitespace and type hierarchy over borders, dividers, and cards. At most one block (pricing) may sit on `--accent-soft` or `--surface` to draw the eye.

## 6. Components

- **Primary CTA (WhatsApp):** full-width on mobile, `--cta-whatsapp` background, white label ≥18 px semibold, WhatsApp icon, 12 px radius, min height 48 px. Appears in the first screen and again at the page end (P-8). Identical both times.
- **Secondary CTA (email):** quiet by comparison — accent-coloured text link or outlined button. Never visually competes with WhatsApp.
- **Photo of Adriana:** one, in the "Sobre" section, modest size (not a hero background), soft-rounded corners (12–16 px). Development placeholder per REQUIREMENTS P-4.
- **Method steps (P-4):** the 4 steps as a simple numbered vertical list — numbers in accent, no icons required.
- **Icons generally:** optional; if used, one outline style, one weight, max ~6 on the whole page, always paired with text. Icons never replace words.
- **Buttons and blocks:** 12 px radius everywhere; shadows either none or a single subtle elevation used at most once.
- **Favicon:** the initial "A" in `--accent` terracotta, centred on a `--bg` paper block with a small border radius (~19 % of the icon size). Both colourways exist — the default, and the inverse (paper "A" on a terracotta block). The served `favicon.svg` carries both and switches on `prefers-color-scheme`, so the icon never sinks into a dark browser chrome. The full set (SVG, ICO, 16/32/192/512 PNG, 180 px apple-touch, each in both colourways) is committed under `public/`; it was generated once by a local script that is deliberately not part of the repository, so neither the build nor CI needs a Python or font toolchain.

## 7. Motion

Effectively none. Allowed: instant hover/focus colour changes and smooth in-page anchor scrolling. Forbidden: scroll-triggered animations, parallax, carousels, entrance effects, animated counters. Respect `prefers-reduced-motion` for the little that remains.

## 8. Accessibility (requirement, not enhancement)

Conformance target: **WCAG 2.2 level AA** (REQUIREMENTS Q-5). The working checklist:

- **Structure:** semantic landmarks (header, main, footer); a single H1 with no skipped heading levels; content reads correctly in source order; page language declared as PT-PT so screen readers pronounce it properly.
- **Keyboard:** every interactive element reachable and operable by keyboard alone, in a logical tab order; visible focus state (accent outline, never removed) on all of them; nothing requires hover to be discovered.
- **Contrast & colour:** AA contrast throughout (§3 — 4.5:1 body, 3:1 large text and interactive component boundaries); no information conveyed by colour alone (e.g. the free first lesson is stated in words, not just highlighted).
- **Text & zoom:** real text, never text baked into images; fully usable at 200 % zoom and at 320 px-wide viewports without loss of content or horizontal scrolling; line height and spacing tolerate user overrides.
- **Non-text content:** Adriana's photo carries meaningful PT-PT alt text; decorative elements are hidden from assistive technology; icons never carry meaning alone (§6).
- **Targets & ergonomics:** touch targets ≥44 × 44 px with spacing between adjacent ones; the two CTAs thumb-reachable.
- **Links & actions:** link/button labels make sense out of context ("Contactar por WhatsApp", never "clique aqui"); the WhatsApp and email actions announce what they do before revealing contact data (P-8's anti-scraping reveal must be equally operable by keyboard and screen reader).
- **Motion:** `prefers-reduced-motion` respected (§7 leaves almost nothing to reduce).
- **Verification:** automated checks (e.g. an accessibility audit tool) plus a manual keyboard-only pass and a screen-reader pass are part of the §10 acceptance — automated tooling alone does not prove conformance.

## 9. What this page will not have

A deliberate exclusion list — each of these has appeared in the rated examples (REQUIREMENTS §4) and each undermines "simple, clean, uncluttered, professional": pop-ups or interstitials of any kind; cookie banners and consent UI (the page sets no cookies and runs no analytics — decided in REQUIREMENTS Q-4); carousels/sliders; stock photos of smiling students; more than one accent colour; background images or gradients behind text; social-media feeds or embedded widgets; badges, seals, or invented "guarantees"; sticky headers taller than one line, or any sticky element that covers content on mobile.

## 10. Acceptance checks (design)

1. On a 360 px-wide phone, the first screen shows: name, offer, levels, Paranhos/Porto, and the WhatsApp button — nothing else competing (REQUIREMENTS P-2).
2. Screenshot test: converted to greyscale, the page hierarchy still reads correctly; the CTA is still the most prominent element.
3. Squint test: at arm's length, exactly one element per screenful draws the eye.
4. Every text/background pair measured and passing AA.
5. Nothing moves on the page unless the visitor initiated it.
6. Accessibility pass per §8: automated audit clean, plus manual keyboard-only and screen-reader walkthroughs reaching the WhatsApp contact end-to-end.
