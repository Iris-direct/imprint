# Art direction: a bespoke portrait, not a template

The card is a **designed object about one specific person and the work they make** — closer to a museum catalog plate, a monograph, or an artist's colophon than to a SaaS landing or a dashboard. It happens to live in a browser. The person should want to frame it, and anyone who knows their field should recognize the field at a glance.

## Why this direction

Every AI-generated page looks the same: purple gradients, glass cards, rounded-2xl grids, emoji confetti. That sameness is the enemy, and it is not only visual — two cards can pass the palette blacklist and still feel identical if they share a skeleton, a narrative spine, and the same AI-prose tics. The whole point is specificity: this page must be legibly about THIS person's craft, in the visual language of THEIR world, in prose a human would actually write. Print culture (books, catalogs, monographs) is the reference for that specificity — committed palette, typographic hierarchy, asymmetry, restraint — but the *form is chosen fresh each time*.

## The rules

**The look is DERIVED from this founder — never a house style.**
This is the skill's core promise, so hold it above every other rule here: **two different founders MUST produce visibly different pages.** Different palette, different materials, different emphasis. If your draft could be dropped onto someone else by swapping only the numbers, you have failed — start over. Any reference card you have seen (including the one shipped in this repo) is ONE realization, not a template; do **not** reach for its palette, its dark ground, its cyan, its terminal panel, or its exact material set by default. Derive everything below from THIS person's `stats.json` and their actual work.

**Legible craft — the person's specialty leads; agent-usage is texture, not the headline.**
The source is Claude Code traces, so it skews heavy on agent-session metrics (sessions, tokens, parallelism). Do NOT let that turn every card into a "solo operator × agent fleet = leverage" pitch — that is the #1 sameness trap, and it makes a game developer and a data scientist read identically. Look past the tooling to the WORK: what does this person actually make, and in what field? A game, a CRM, a design system, a social app, a compiler, a research notebook, a music tool, a mapping engine. That craft is the spine of the card and sets its visual world. Agent-leverage is reported as one quiet stat among many; it becomes a headline ONLY when building agentic systems is genuinely the person's craft (they ship agent tooling, or orchestration is demonstrably their edge). Test: "if I hid the numbers, could a stranger tell what field this person works in from the page alone?" If not, the craft isn't leading yet.
**The subject is the PERSON, not the agent.** Describe what THEY build, ship and decide. Never foreground agent-move counts, token totals, parallel-session tallies, or "the tool builds itself" — that describes the agent's output, not the person's work. Frame every metric as the person's own activity (they shipped, they run N ventures, they hold this rhythm). The traces are evidence of a human building; write the human.

**Never leak the build.** Do not diagram or name the product's internal architecture: no pipeline of proprietary internals, no internal module/function/endpoint names (e.g. compiler stages, `materialize_world`, `/s/:token`), no references to internal design docs (`architecture.md §…`), no verbatim commit subjects that expose internal mechanics. Describe the product from the OUTSIDE — what it is and does for a user or investor — not how it is engineered. If the month's journal would leak internals, replace it with a plain, surface-level statement of what the person focused on.

**Ground & palette — from the flagship's own identity, then committed.**
Look at what the person actually builds and let their flagship's visual identity set the page's ground. If its design language is discoverable (its repo, README, screenshots, brand), wear *that*: it may be warm and editorial, stark monochrome, neon-on-black, soft pastel, corporate Fluent-blue, brutalist concrete, terminal-green — anything, as long as it's *theirs* and not an AI-slop default. If it isn't discoverable, compose a committed palette from the person's temperament and rhythm (day-worker → warm paper + near-black ink + one accent; night-worker → deep ground + bone + one phosphor). Keep it disciplined: ground + ink + one accent + one muted support; validate contrast (body ≥ 7:1, captions ≥ 4.5:1). Commit fully — no theme toggle, art has no dark mode.
**Actually go look, and match the real intensity.** Open their live site/product with a browser tool if you have one, or read their real design tokens / CSS straight from the repo — do not imagine a "tasteful" version. The most common failure is **under-shooting**: a person who builds hard cyberpunk (near-black, neon cyan/magenta/violet, glow, scanlines, glitch) must get a hard-cyberpunk card, not a clean GPT-safe reduction of it. Reproduce the boldness that is actually there. For a person's OWN personal card especially, go maximal in their real language.

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

**Data as bespoke marks, invented per person — not a fixed widget set.**
Charts are hand-drawn in the palette's ink, no libraries, labelled directly on the mark. But do NOT default to the same trio every time (radial clock + language spectrum + catalog list) — that trio is a big reason cards feel like siblings. Invent the visualization from the person's domain:
- rhythm (when they work) → a radial clock is ONE option; also a tide chart, a music staff, a light-cycle strip, a heat-bar — pick what suits their world.
- what they make → a constellation, a shelf, a floorplan, a skill-tree, a contour map, an org of files — a form that echoes the craft.
- language/tool mix → tiny ex-libris marks, a pressed-flower spectrum, a materials swatch board — not a pie chart, and not always the same bar.
- A game dev's card can carry a pixel/sprite motif; a cartographer's, contour lines; a musician's, a waveform; a data scientist's, their actual plot idiom; an infra person's, a topology graph. Same data, a mark that is theirs.
- If a dataviz skill is available, consult it for form/accessibility; its neutral palette does NOT apply — this page's palette wins.

**Go deep — use the full visual toolbox; every card is a bespoke artifact.**
This is not a form to fill. Spend real design effort per person: a type system chosen for them, bespoke inline SVG built from their domain, ornament and texture that mean something (a seeded generative motif, a hand-drawn rule, a domain emblem, a considered grid). Reach for everything the medium allows — SVG, CSS, canvas, generative geometry, custom counters and marks — as long as it stays self-contained and offline-safe. The bar a designer would set: "someone made this on purpose, for this one person." Depth is intention, not decoration — restraint and the slop blacklist still hold; more effort, not more clutter.

**No shared silhouette.**
Before finishing, imagine this card beside the last one the skill made. If they share a silhouette — same ground tone, same section rhythm, same clock-then-spectrum-then-catalog order, same serif-display-over-mono pairing — you have templated. Change the form until the two could not be mistaken for a set.

**Multilingual — a toggle, not a translation dump.**
Default language = the user's dominant prompt language; when it isn't English, add an English locale (investors read English) with a small RU·EN-style toggle in the plate. Implementation for a self-contained page: paired `.ru`/`.en` spans + `body[data-lang]` CSS, choice persisted in localStorage, `?lang=` param honored, chart labels redrawn on switch. **Verbatim telemetry is never translated** — commit subjects, prompt quotes stay in their original language in both locales (translate only surrounding labels); numbers adapt punctuation (5,8% ↔ 5.8%).

**«Прочтение» — visibly different voice.**
The interpretation layer (investor-read) is italic serif with an accent rule, prefixed with a small label «интерпретация · не факты». The reader must never confuse interpretation with evidence.

**Tone — vital, proud, lightly witty.**
This is a визитка the person shows with pride, not a burnout diagnosis. The same fact can read as sacrifice or as strength; always choose strength: «работал без отпуска» → «семьдесят пять дней станок не останавливался»; «календарь подчинён работе» → «сам решает, когда начинается неделя». Celebrate rhythm, freedom, and craft; never diagnose. Keep the reframes honest and un-slick — a proud line is not an aphorism-punchline, and it still has to pass the humanizer pass below. Melancholy, grind-vibes, and loneliness framings are blacklisted alongside the visual slop.

**Prose — human, not generated (run the humanizer pass).**
The paragraphs are the biggest AI-tell and a hidden source of sameness: cards that all reach for the same aphorism-punchlines («не история успеха — история дисциплины»), the same rule-of-three, negative parallelisms («не X, а Y»), em-dash drama, and significance inflation read as one AI writing all of them. After drafting, run every prose block through the **humanizer** skill (`blader/humanizer`, install alongside imprint) — or apply its patterns directly: cut manufactured punchlines and aphorism formulas, drop rule-of-three and «не X, а Y», replace em-dash drama with plain punctuation, strip significance inflation and promotional adjectives, prefer «is/has» over «serves as/boasts». Humanizer's hard rule holds: no fabrication — specificity comes only from the data, never invented. Where the person's own prompt voice is visible, match its rhythm instead of producing generic clean copy.

**Blacklist (instant fail):**
- Default purple/blue-on-dark gradients and habitual glassmorphism — reached for out of habit rather than derived (either is allowed ONLY when it is genuinely the flagship's own identity); `border-radius: 16px+` pill-card grids
- Emoji as decoration, progress bars for "skills", star ratings
- Corporate hero sections, CTA buttons (nothing on this page is clickable except the colophon link)
- Theme toggles, cookie-banner aesthetics, drop shadows deeper than a whisper

## Movements (compose 4–6 that fit THIS person — not a fixed skeleton)

There is NO required section set or order. Compose the card from movements that suit the person's craft, name them in their own language, and lead with their real strength. The only immovable parts are the two-layer honesty contract (evidence vs labelled interpretation) and the privacy pass. Draw from these, and freely rename, drop, add, split, or reorder:

- **Title** — the person's NAME as h1 (no poetic archetypes); a one-line positioning of what they make; the framing «телеметрия, не резюме» and the dates.
- **Now** — the native month journal: 1–2 sentences plus 5–8 verbatim own-repo commit subjects (`git log --since="30 days ago"`), styled as a live log. Own repos only, never client/NDA.
- **The work / craft** — the substance of what they build this month, shown in the visual language of their field. This is usually the spine; lead here for most people.
- **Velocity** — shipping tempo (commits, pushes, lines, reaches-prod), when it is a genuine strength.
- **Rhythm** — when they work, as a bespoke time-mark (see *Data as bespoke marks*).
- **Portfolio** — projects catalog; own work named, client/NDA aggregated namelessly.
- **Leverage** — OPTIONAL, and NOT the default. Include a leverage movement only when agent-orchestration is genuinely this person's story; otherwise fold the single most honest leverage stat into Velocity as texture. Never let it become the card's spine unless building agents IS the craft.
- **Reading** — the labelled interpretation layer: what the numbers suggest about their craft and character; hedged, honest. Not a generic founder-to-investor pitch.
- **Colophon** — methodology + «данные не покидали машину» + a quiet imprint link.

Litmus: if two different people would get the same movements, in the same order, with the same marks, you are templating. Vary the composition until the card belongs to this person alone.
