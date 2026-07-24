# Art direction: печатная культура, деловой тон

The card is a **printed object that happens to live in a browser** — an annual-report spread from a great print house, a catalog page about one founder. Not a SaaS landing, not a dashboard. An investor should want to keep it.

## Why this direction

Every AI-generated page today looks the same: purple gradients, glass cards, rounded-2xl grids, emoji confetti. That sameness is the enemy — a founder's credibility card must say "a specific person, verified numbers". Print culture (books, catalogs, annual reports) carries that specificity: committed palette, typographic hierarchy, asymmetry, restraint. The craft is premium; the copy is business-grade.

## The rules

**The look is DERIVED from this founder — never a house style.**
This is the skill's core promise, so hold it above every other rule here: **two different founders MUST produce visibly different pages.** Different palette, different materials, different emphasis. If your draft could be dropped onto someone else by swapping only the numbers, you have failed — start over. Any reference card you have seen (including the one shipped in this repo) is ONE realization, not a template; do **not** reach for its palette, its dark ground, its cyan, or its exact material set by default. Derive everything below from THIS person's `stats.json` and their actual work.

**Ground & palette — from the flagship's own identity, then committed.**
Look at what the person actually builds and let their flagship's visual identity set the page's ground. If its design language is discoverable (its repo, README, screenshots, brand), wear *that*: it may be warm and editorial, stark monochrome, neon-on-black, soft pastel, corporate Fluent-blue, brutalist concrete, terminal-green — anything, as long as it's *theirs* and not an AI-slop default. If it isn't discoverable, compose a committed palette from the person's temperament and rhythm (day-worker → warm paper + near-black ink + one accent; night-worker → deep ground + bone + one phosphor). Keep it disciplined: ground + ink + one accent + one muted support; validate contrast (body ≥ 7:1, captions ≥ 4.5:1). Commit fully — no theme toggle, art has no dark mode.

**Track materials — from the actual tools & languages, one per track.**
Each section's material is *earned* by what this person actually used, so the page reads like a mixtape of their real workshop. The dominant tool sets a track's material. These are illustrations of the mapping, NOT a fixed set to reuse — pick what fits this toolset, invent new materials when the data suggests them:
- terminal/CLI-heavy → a terminal panel (dark ground, mono, prompt marks)
- design/Figma/CSS-heavy → a design-canvas or swatch material (artboards, rulers)
- writing/docs/notebook-heavy → a manuscript or ruled-notebook material
- data/SQL/Python-heavy → a ledger or plotted-grid material
Languages appear in their **official brand colors** (TypeScript blue, JS yellow, Rust rust, Go cyan, Swift orange…) in a labeled spectrum bar — color follows the real entity, not decoration. Cohesion: one grid, one type system, a small «трек NN · материал: …» label per section; ≤3 distinct materials on the page; every color traceable to something the person actually worked with. Data-derived ≠ chaos.

**Emphasis & recency — lead with this founder's strength, weighted to the last month.**
Compute material shares and project mix from the last ~30 days of sessions (not the whole span) — the page shows who they are NOW; state the shares in the liner note («в этом месяце звучит: …»). Then **lead with whatever is genuinely strongest for THIS person**: a rare leverage ratio, or relentless velocity, or a sustainable rhythm, or deep single-product focus. If one project dominates the recent month (>50%), its identity can become the page ground; if the person is a portfolio juggler, the ground may instead come from their temperament. Don't force every card through one emphasis — the sections may be reordered or resized to fit the person; only the honesty contract and privacy pass are fixed.

**Native narrative — «Сейчас», the month's journal.**
Right after the title, a section tells what the person is building THIS month, natively: 1–2 sentences of prose + a journal of 5–8 verbatim commit subjects from the user's OWN flagship repo (`git log --since="30 days ago"`), styled as a live log (type prefixes colored: feat/fix/docs). Commit subjects are the person's own poetry — don't paraphrase them. NEVER source this journal from client/NDA repos; own repos only.

**Typography — the design IS the typography.**
- Display serif with real Cyrillic: Playfair Display, Spectral, Cormorant Garamond, or Literata. Huge sizes for the archetype title (clamp 3.5–7rem), tight leading, optical margins.
- Text: same serif at reading size, or a quiet humanist sans (IBM Plex Sans).
- Data/numbers: a mono with Cyrillic (JetBrains Mono, IBM Plex Mono) — numbers are typographic specimens: large, tabular, footnoted.
- Google Fonts allowed with system fallbacks (`Georgia, serif` / `ui-monospace`); the page must survive offline.

**Layout — asymmetric, editorial.**
- One column of meaning with wide margins; marginalia in the margins (that's where «Между строк» lives).
- Numbered sections like a catalog (01, 02, 03…), thin rules, generous whitespace.
- Max-width ~1000px; must read beautifully at 375px too (margins collapse, marginalia become inline asides).
- Subtle paper grain or ink texture via CSS (radial-gradient noise, low opacity) is welcome; keep it under 3% visual weight.

**Data as engravings, not widgets.**
- 24h rhythm → inline SVG **radial clock** (hand-drawn feel: thin strokes, small caps labels «полночь/полдень»), bars from `hour_histogram`.
- Projects → a constellation or a catalog list with em-dash annotations, weight = session count.
- Language/tool mix → tiny inline marks (ex-libris style), not pie charts.
- Every chart drawn in the palette's ink; no chart libraries, no gridlines-by-default; label directly on the mark, no legends if avoidable.
- If a dataviz skill is available, consult it for form/accessibility; its neutral palette does NOT apply — this page's palette wins.

**Multilingual — a toggle, not a translation dump.**
Default language = the user's dominant prompt language; when it isn't English, add an English locale (investors read English) with a small RU·EN-style toggle in the plate. Implementation for a self-contained page: paired `.ru`/`.en` spans + `body[data-lang]` CSS, choice persisted in localStorage, `?lang=` param honored, chart labels redrawn on switch. **Verbatim telemetry is never translated** — commit subjects, prompt quotes stay in their original language in both locales (translate only surrounding labels); numbers adapt punctuation (5,8% ↔ 5.8%).

**«Прочтение» — visibly different voice.**
The interpretation layer (investor-read) is italic serif with an accent rule, prefixed with a small label «интерпретация · не факты». The reader must never confuse interpretation with evidence.

**Tone — vital, proud, lightly witty.**
This is a визитка the person will show with pride, not a burnout diagnosis. The same fact can read as sacrifice or as strength — always choose strength: «работал без отпуска» → «семьдесят пять дней музыка не останавливалась»; «одиночка» → «команда из одного человека и ста агентов»; «календарь подчинён работе» → «сам решает, когда начинается неделя». Celebrate rhythm, freedom, and craft; never diagnose. Melancholy, grind-vibes, and loneliness framings are blacklisted alongside the visual slop.

**Blacklist (instant fail):**
- Default purple/blue-on-dark gradients and habitual glassmorphism — reached for out of habit rather than derived (either is allowed ONLY when it is genuinely the flagship's own identity); `border-radius: 16px+` pill-card grids
- Emoji as decoration, progress bars for "skills", star ratings
- Corporate hero sections, CTA buttons (nothing on this page is clickable except the colophon link)
- Theme toggles, cookie-banner aesthetics, drop shadows deeper than a whisper

## Structure contract (a default skeleton, not a cage)

Sections below are the default order; reorder or resize them to lead with this founder's real strength (see *Emphasis* above). The two-layer honesty contract and the privacy pass are the only immovable parts — everything else adapts to the person.

1. **Титул** — the person's NAME as h1 (no poetic archetypes), deck line = positioning: what they build, one confident sentence naming the flagship venture; then «ниже — телеметрия, не резюме» framing and dates span.
1b. **01 · Сейчас** — the native month journal (see Recency/Native narrative above): recent-month share stats + verbatim own-repo commit log.
2. **02 · Скорость** — shipping velocity: sessions/day, commits, pushes, lines, files, projects; prose: reaches prod, not just branches.
3. **02 · Кратность** — the AI-leverage story: human:agent ratio, parallel-session %, tokens produced, verification volume, response cadence. The capital-efficiency message. Voice-specimen marginalia (contentless imperatives) may live here.
4. **03 · Ритм** — radial clock + night %, weekday pattern, marathon stats; prose: sustainable pace, founder controls the calendar.
5. **04 · Портфель** — projects catalog: own flagship named; client/NDA work aggregated namelessly (may note it funds independence); factory/experiments.
6. **05 · Прочтение** — the labeled interpretation layer: what an investor should conclude; hedged, honest.
7. **Колофон** — methodology: «Составлено Claude по N сессиям · период · данные не покидали машину», quiet link to the imprint project.
