---
name: imprint
description: Generate an "imprint" — a bespoke, deeply designed one-page HTML portrait of a person built from their Claude Code usage traces: what they make and in what field, their craft, shipping tempo, and work rhythm, rendered in the visual language of their own work. Publish it to a PRIVATE GitHub repo (public only after explicit consent). Works for founders, engineers, designers, and makers of any specialty — not only agent builders. Use whenever the user runs /imprint, asks for their card / визитка / профиль / "who am I based on my data" / "покажи мой профиль по сессиям", wants to showcase how they work, or asks to (re)publish, update, or "make my imprint public".
compatibility: Requires python3 and local ~/.claude data. Publishing requires gh CLI (authenticated); without it, the skill still produces the local card.
---

# imprint — a bespoke portrait from real traces

You are making a **bespoke portrait of one person and the work they make**, built from their real working traces — numbers taken from actual sessions, not a pitch deck. It can serve a founder pitching investors, but it is first a truthful, beautifully designed picture of how this specific person works and what they build, whatever their specialty. Two things carry it: design that belongs to THIS person's craft (never a house template), and honesty (the two-layer evidence/interpretation contract, so nothing reads as inflated). The failure mode to fear most: every card coming out the same — same skeleton, same "solo operator × agent fleet" story, same AI-prose. Fight that on every card.

## Pipeline

1. **Collect** — run the bundled collector:
   ```bash
   python3 <skill-dir>/scripts/collect_stats.py ~/imprint/stats.json
   ```
   It scans `~/.claude` (session-meta, facets, project transcripts as fallback) and writes one `stats.json`. It never sends anything anywhere. If it errors, fix the environment, not the honesty of the data.

2. **Read the person and their craft, not just the data.** Study `stats.json` for who this is and what they make:
   - **The craft** — what do they actually build, and in what field? Name the flagship and the domain (a game, a CRM, a design system, an infra tool, a social app, a research notebook, a music tool…). This is the spine of the card and sets its visual world.
   - **Velocity** — sessions/day, commits, pushes, lines shipped, "reaches prod" signals — when it's a real strength.
   - **Rhythm** — peak hours, protected nights, weekend pattern, marathon tolerance: their working shape.
   - **Leverage (optional lens)** — human-to-agent ratio, parallelism, own tooling. Report it as quiet texture; make it a headline ONLY if building agentic systems is genuinely their craft. Do not turn every card into a "solo operator × agent fleet" pitch — that is the #1 sameness trap (see design.md → *Legible craft*).
   - **Quality discipline** — verification tooling (screenshots/preview), satisfaction/outcome facets, evidence-first habits.

3. **Two layers, never blurred.** The card's honesty contract:
   - **Показатели (Evidence)** — claims backed by numbers in `stats.json`, every one traceable to a field, with footnote-style source notes.
   - **Прочтение (Interpretation)** — what the numbers say about this person's craft and character. Visually distinct, explicitly labeled («интерпретация · не факты»), hedged honestly. Never state an interpretation as fact; never invent specifics about personal life — patterns only.

4. **Privacy pass (hard rules).** Before writing a single line of HTML:
   - No secrets, keys, tokens, emails, phone numbers, client names, or third-party personal data — even if they appear in prompts.
   - **Name only projects the user owns.** Client, employer, and NDA work appears strictly anonymized and aggregated («заказные проекты — N сессий»), with no names, domains, product specifics, or recognizable details. When ownership is unclear, treat it as NDA. A client must be unable to recognize their project on the card.
   - **Never leak the build.** Do not expose the internal architecture of the person's OWN product either: no pipeline/architecture diagrams, no internal module/function/endpoint names, no internal design-doc references, no verbatim commits that reveal proprietary mechanics. Describe the product from the outside (what it does for a user), not how it's engineered.
   - Quote prompts only as short fragments with zero work content (generic imperatives, voice specimens). When in doubt, paraphrase or drop.
   - Raw data (`stats.json`, transcripts) is NEVER committed or published. Only the finished card.

5. **Titling is professional.** The h1 is the **person's name** (from `git config user.name` or ask); the deck line is their positioning: what they build, in one confident sentence. No poetic archetypes in the title — the poetry lives quietly in the craft, not the copy.

6. **Design — deep and bespoke.** Read `references/design.md` — the binding art direction. **Actually look at their real work** (open their live site/product with a browser tool, or read their real design tokens/CSS from the repo) and match its true aesthetic and intensity — don't sand a bold style (e.g. cyberpunk) down to a safe GPT-clean default. Compose the card's movements to fit THIS person's craft (no fixed skeleton), derive palette/materials/marks from their own work, and spend real design effort: bespoke inline SVG from their domain, a type system chosen for them, data-marks invented per person (not the same radial-clock-plus-spectrum every time). If a dataviz skill is available, consult it for form/accessibility; the manifesto wins on style. Write the card to `~/imprint/index.html` in the user's dominant prompt language; when that isn't English, build it bilingual with a language toggle (verbatim telemetry stays untranslated).

7. **Humanize the prose.** After the draft, run every prose block through the **humanizer** skill (`blader/humanizer`) — or apply its patterns — to strip AI-tells: aphorism-punchlines, rule-of-three, «не X, а Y» negative parallelisms, em-dash drama, significance inflation, promotional adjectives. Hard rule: no fabrication; specificity comes only from the data. Then open the card for the user.

8. **Offer the loop.** Show the card, ask what to fix. Iterate until they say "это точно я".

9. **Then offer to publish — and do all the work yourself.** Read `references/publish.md` and follow it. A card that never leaves the disk is a card nobody sees, and the person came here to have something to show. Once they're happy, make the offer once, plainly: their own live URL (`https://<login>.github.io/imprint/`), a share image for reposting, and — if they want — a PR into the community gallery. On one explicit yes you run every step: repo, Pages, `card.png`, OG meta, fork and PR. They should never have to fork, copy files into paths, or open a PR by hand. No yes → everything stays local, no nagging.

## Quality bar (check before showing)

- **Derived, not templated.** Palette, materials, movements, and marks come from THIS person's craft and real tools — not a reused house look. Swap-test: if this page would fit someone else by changing only the numbers, redo it.
- **Craft is legible.** A stranger could tell what field this person works in from the page alone. Agent-leverage is texture, not the spine — unless building agents is genuinely the craft.
- **No shared silhouette.** This card could not be mistaken for a set with the last one the skill made (different ground, movement set, marks, type pairing).
- Every Evidence claim has a number behind it; every Interpretation is visibly labeled as such.
- Charts are drawn from real data, in forms invented from the person's domain — not the same radial-clock+spectrum every time.
- **Prose passes the humanizer bar:** no aphorism-punchlines, rule-of-three, «не X, а Y», em-dash drama, or significance inflation. Reads like a human wrote it.
- Tone: confident, concrete, zero буллшита — no "visionary", no superlatives without numbers; vital, never grind-glorifying or melancholic.
- Works offline as a single file; survives missing web fonts.
- Footer colophon: methodology + «сделано скиллом imprint — сделай свой» linking the project repo. Quiet, tasteful.
- No AI-slop visuals (manifesto blacklist) and no client-recognizable details (privacy pass).
- **They end up with something to show.** Either a live URL + share image (if they said yes to publishing), or a clear local path and a standing offer. Never end the session with the card stranded on disk and the publish option never mentioned.
