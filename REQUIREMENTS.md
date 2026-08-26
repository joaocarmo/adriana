# REQUIREMENTS.md — Single-Page Website for Private Tutoring (Explicações)

Product requirements only. No technical decisions (hosting, framework, tooling) are made in this document.

## 1. Background

A single-page website for **Adriana**, a private tutor (explicadora) in **Porto**, offering in-person lessons in **Português, Inglês e Francês** for pupils in the **2.º e 3.º ciclos do ensino básico** (5.º–9.º ano), including pupils with specific needs (PHDA, dislexia). Lessons take place at her home, in a study room dedicated to teaching. The site is greenfield: no brand or domain exists. Her current tutor-marketplace profile is the factual source for §5's content requirements; the profile also offers online lessons, but a deliberate decision was taken that **this page advertises in-person lessons only**.

## 2. Goal

**Primary goal:** convert visitors — chiefly parents/guardians — into new student enquiries.

**Secondary goal:** serve as a credible professional presence to link from social media, classified ads (e.g. tomaconta, Zaask), and word-of-mouth referrals.

Explicit non-goals: online booking/payment, a blog, multi-page navigation, a student portal, online lessons.

## 3. Target audience

- **Primary:** parents/guardians of pupils in the 2.º–3.º ciclos, browsing predominantly on a phone, often arriving from a shared link or a search for local explicações.
- **Secondary:** older pupils (8.º–9.º ano) researching for themselves.

The audience is local: only families within reach of the in-person lesson location(s) are relevant.

## 4. Research: existing examples, rated

Rated 1–5 on the criteria that matter for the enquiry-generation goal. Sources: direct inspection where possible, otherwise published analyses (linked in §4.3).

### 4.1 Ratings

| #   | Example                                         | Type                | Offer clarity | Contact/CTA friction | Trust signals | Pricing transparency | Fit to our case | Overall |
| --- | ----------------------------------------------- | ------------------- | :-----------: | :------------------: | :-----------: | :------------------: | :-------------: | :-----: |
| 1   | Explicas.me (PT marketplace)                    | Marketplace         |       3       |          3           |       4       |          1           |        2        |   2.6   |
| 2   | ExplicaNet / Ginásios Da Vinci (PT chain)       | Chain               |       4       |          3           |       3       |          5           |        3        |   3.6   |
| 3   | Tomaconta classified listings (PT)              | Classifieds         |       2       |          3           |       1       |          3           |        2        |   2.2   |
| 4   | Preply tutor profiles (PT-facing)               | Marketplace profile |       4       |          4           |       4       |          5           |        3        |   4.0   |
| 5   | Katie Tutors Math (individual, intl.)           | Individual tutor    |       5       |          4           |       4       |          5           |        4        |   4.4   |
| 6   | Online Tutoring with Kirsty (individual, intl.) | Individual tutor    |       4       |          5           |       5       |          4           |        3        |   4.2   |
| 7   | NMS Tuition (individual language tutor, intl.)  | Individual tutor    |       4       |          5           |       3       |          2           |        4        |   3.6   |
| 8   | Dyslexia Deb (individual specialist, intl.)     | Individual tutor    |       5       |          4           |       3       |          2           |        3        |   3.4   |

### 4.2 What the ratings taught us

1. **Pricing transparency is a differentiator in the Portuguese market.** Explicas.me shows no prices at all; ExplicaNet publishes a full rate table (€21–25/h for secondary) and gains trust from it. Published analyses report that vague pricing frustrates parents and wastes both sides' time, while displayed rates pre-qualify enquiries. → Requirement P-6.
2. **Individual tutors beat institutions on personal trust, and the best ones lean into it.** The top-rated examples (5, 6) put a real name, photo, credentials, and a methodology statement front and centre. ExplicaNet's biggest weakness is exactly the absence of a visible human being and of any testimonial. → Requirements P-4, P-5.
3. **Specialisation raises perceived value.** Sites with a narrow, named niche (maths only; dyslexia only) rate higher on offer clarity than generalist marketplaces. "Português, Inglês e Francês — 2.º e 3.º ciclos" is a clear, honest niche and must be stated verbatim in the first screen. → Requirement P-2.
4. **Contact friction kills enquiries.** Reported research: a majority of parents abandon when contact requires multi-step back-and-forth. Best examples put a one-tap contact action on every screen. → Requirement P-8.
5. **Mobile is the primary device.** Over half of traffic to tutoring sites is mobile; every rated weakness compounds on a small screen. → Requirement Q-1.
6. **Marketplaces are the competition, not the model.** Their strengths (scale claims, media logos) are unavailable to an individual; their weaknesses (anonymity, no prices, generic categories) are precisely where a personal one-pager can win.

### 4.3 Sources

- [Explicas.me](https://www.explicas.me/) · [ExplicaNet](https://www.explicanet.com/) · [Tomaconta — explicações](https://www.tomaconta.com/anuncios/explicacoes) · [Preply tutor profile (PT)](https://preply.com/pt/professor/8075)
- [Vida — Tutoring Website Examples That Convert](https://vida.io/blog/tutoring-website-examples) · [Zarla — 20 Tutoring Website Examples](https://www.zarla.com/guides/tutoring-website-examples) · [Heek — Best Private Tutor Websites](https://www.heek.com/private-tutor/best-private-tutor-websites) · [Colorlib — Tutoring Website Examples](https://colorlib.com/wp/tutoring-website-examples/)

## 5. Product requirements

"Must" requirements are in scope for the first version. Section order on the page should follow the order below (P-1 → P-9).

### P-1 — Single page (Must)

All content lives on one page. Any navigation is in-page anchors only. The page must be fully understandable when read top to bottom without clicking anything.

### P-2 — Value proposition above the fold (Must)

The first screen states, in European Portuguese, without scrolling on a typical phone: who she is (**Adriana, explicadora**), what she offers (**explicações individuais presenciais de Português, Inglês e Francês**), for whom (**2.º e 3.º ciclos / 5.º ao 9.º ano**), where (**Porto** — at her home), and one primary contact action (see P-8). No slogan may replace this concrete information.

### P-3 — Subjects and levels block (Must)

A section listing the three subjects and the exact school years covered (5.º–9.º ano), so a parent can confirm fit in seconds. If any subject has a narrower level range than the others, it must be stated per subject, not averaged.

This section also names her specialisation in supporting pupils with **PHDA (défice de atenção e hiperatividade) and dislexia** — the research (§4.2, lesson 3) shows a named specialism is a stronger differentiator than generic quality claims, and it is a claim she can substantiate from direct experience.

### P-4 — About the tutor (Must)

A short personal section with a photo of her and her actual credentials, drawn from her profile. During development the photo is a **clearly-marked placeholder** (obviously not a real person — an illustration or silhouette, never a stock photo that could be mistaken for her), replaced with her real photograph at deploy time; the page must not go live to the public with the placeholder. Credentials: licenciatura em Línguas e Relações Internacionais, Mestrado em Ensino in progress, 2 years' experience in education (individual explicações and estudo acompanhado with large groups), direct experience with PHDA and dislexia, and a dedicated study room at her home offering a calm, focused environment.

The section must also present her 4-step method in her own terms: **avaliação inicial** (identify difficulties and learning style) → **explicação prática** (simplify material with schemas and clear examples) → **resolução de exercícios** (fichas and past tests) → **método de estudo** (organisation and summarising techniques for autonomy). This answers the parent's implicit question "who will be alone with my child, and do they know what they're doing?".

### P-5 — Social proof (Must, may launch minimal)

No testimonials exist at launch, so the page launches with concrete statements she can honestly make instead (e.g. 2 years' experience in education, individual and group settings, experience with PHDA and dislexia). Fabricated or placeholder testimonials are prohibited. The section is designed so genuine testimonials (with consent) can be added as they arrive.

### P-6 — Pricing (Must)

Prices are displayed on the page, per her current offer: **15 €/hora** and a **free first lesson (1h)**. No packs are advertised. The page states that **she issues a receipt (recibo)** — a trust signal and practically useful to parents (education expenses are IRS-deductible in Portugal), stated next to the price. Any conditions must be stated next to the price, not discovered later. Prices must be easy to update. The free first lesson is a strong friction-remover and should be prominent (research §4.2, lessons 1 and 4).

### P-7 — Practical details (Must)

Lessons take place **at her home in Porto (Paranhos)**, in a dedicated study room — the page states the freguesia so parents can judge the commute. Online lessons are deliberately not advertised (see §1), and the page must not mention them. Typical session length: **1 hora**. Availability is not published on the page — it is agreed per enquiry ("horários mediante consulta"), which also keeps the contact action as the natural next step. School-year framing (enrolment periods, exam-period support) remains optional content she may add later.

### P-8 — Contact / call to action (Must)

Two channels: a **WhatsApp link** (primary — one tap on mobile, repeated at top and bottom of the page) and an **email address** (alternative). Every enquiry path states the committed response time: **resposta em 24 horas**.

**Anti-scraping requirement:** her phone number and email address must not be harvestable by bots, crawlers, or scammers. As product behaviour: neither contact detail appears as plain machine-readable text in the page source or in search-engine snippets; contact details are revealed only through a deliberate visitor action (e.g. tapping a "Contactar por WhatsApp" button); and the WhatsApp link may pre-fill a message so genuine enquiries are effortless. The protection must not add friction for a real parent — one tap still reaches her. The specific protection technique is an implementation decision, not fixed here; this requirement fixes only the outcome (unscrapable to automated harvesters, effortless for humans).

### P-9 — Language and tone (Must)

All visitor-facing content in **European Portuguese**, following the **Acordo Ortográfico de 1990**, applied consistently; no Brazilian variants. Tone: warm, professional, addressed to parents ("o seu educando" / "o seu filho" register to be decided with her). All content she must approve before launch.

## 6. Quality requirements (product level)

- **Q-1 (Must):** The page is designed mobile-first. Every requirement in §5 must hold on a small phone screen; the P-2 first screen and one-tap contact are acceptance criteria, not aspirations.
- **Q-2 (Must):** The page loads fast enough not to lose an impatient parent on a mid-range phone on mobile data — perceived load under ~2–3 seconds.
- **Q-3 (Must):** Findable by locals: the page's visible text names the locality and "explicações" naturally, so it can rank for "explicações [localidade]"-type searches.
- **Q-4 (Must):** The page collects nothing: **no analytics, no cookies, no forms, no third-party embeds that set identifiers**. Consequently no consent banner and no privacy notice are required — and none may appear. This is a decided constraint, not a conditional: adding any tracking later reopens the RGPD consent question and violates this requirement as written.
- **Q-5 (Must):** The page follows accessibility best practice, with **WCAG 2.2 level AA** as the conformance target. As product behaviour: everything can be reached and operated by keyboard alone and by screen reader; content reads in a logical order with correctly announced language (PT-PT); text and interactive elements meet AA contrast; the page remains fully usable at 200 % zoom and with motion reduced; no information is conveyed by colour alone. Accessibility is an acceptance criterion for launch, not an enhancement — DESIGN.md §8 carries the working checklist.
- **Q-6 (Should):** When the link is shared (WhatsApp, Messenger), the preview shows her name, offer, and photo/graphic — since sharing between parents is an expected acquisition channel.

## 7. Decisions log (all open questions resolved)

- **Identity:** no brand name; the page uses her plain name, Adriana.
- **Locality:** Porto — Paranhos, lessons at her home; in person only.
- **Pricing:** 15 €/hora, free first lesson (1h), no packs; recibo issued (stated on the page next to the price).
- **Contact:** WhatsApp link (primary) + email, scrape-protected per P-8; committed response time 24 hours.
- **Social proof:** no testimonials at launch; honest results statements instead (P-5).
- **Spelling:** Acordo Ortográfico de 1990.
- **Domain:** already owned; not needed during development (record it when wiring up deployment).
- **Measurement:** no analytics of any kind (Q-4). New-student attribution happens conversationally ("como nos encontrou?").
- **Copy source:** the page text is adapted from her existing tutor-profile text (the PDF provided), which she wrote — Adriana still approves the final adapted copy (P-9).
- **Contact data handling:** her WhatsApp number and email address are never committed to the repository; they are stored as GitHub secrets and injected at deploy time. This complements P-8's anti-scraping outcome (the data also never appears in source history).

- **Photo:** placeholder during development, replaced with her real photograph at deploy time (P-4); launch is blocked until the real photo is in place.
- **Sessions:** 1 hora typical length; availability agreed per enquiry, not published (P-7).

No inputs remain outstanding. The real photo is needed only at deploy time.

## 8. Success criteria

- A parent landing on the page can answer, within 30 seconds on a phone: _what is offered, for which years, where, at what price, and how do I get in touch_ — this is the acceptance test for the page as a whole.
- Enquiries arrive through the page's contact action(s); she can attribute new students to the site ("como nos encontrou?").
- She can get pricing/availability text updated easily at the start of each school year (process requirement on whoever maintains the page).
