# Publishing: one yes, the agent does the rest

The card is a portrait of a real person, so nothing goes public without their explicit yes. But when they DO want it public, **they should not have to do any of the work** — no forking, no copying files into paths, no opening PRs by hand. You do all of it. Their only job is to say yes and then have a link they're proud of.

Why this matters: a card that lives only on disk is a card nobody sees. The person came here to have something to show. Finish the job.

## Workdir

Everything lives in `~/imprint/` (override via `IMPRINT_DIR`):

```
~/imprint/
├── index.html      # the card — the only thing that gets published
├── card.png        # share image (generated at publish time)
├── README.md
├── .gitignore      # stats.json + raw data
└── stats.json      # local only, never committed
```

`.gitignore` must contain at least:
```
stats.json
*.jsonl
```

If `~/imprint` happens to be a checkout of the imprint *project* repo (the author's case), personal cards live in `personal/` there, which is gitignored — never commit a personal card into the project repo.

## The offer — three levels, not one yes/no

A card about how someone works is personal. Plenty of people want to show it to an investor or two without putting their working hours on the open internet, and collapsing that into "publish or don't" loses them. Offer the levels explicitly and let them pick:

> «Куда её деть?
> **1. Оставить у себя** — файл и картинка на диске, никуда не уходят. Пересылаешь лично кому хочешь.
> **2. Ссылка для своих** — подниму страницу на твоём GitHub, но закрою её от поиска и никуда не добавлю. Ссылка работает, по имени тебя не находит.
> **3. Публично** — то же плюс карточка в общей галерее iris.direct/imprint-profiles, PR отправлю сам.»

**Be straight about what level 2 actually is.** It is obscurity, not secrecy, and saying so is the difference between informed consent and a nasty surprise:

> «Оговорюсь: ссылка не индексируется и нигде не висит, но кто её получил — может переслать дальше, а на бесплатном GitHub репозиторий с этой страницей всё равно публичный. Если нужна настоящая приватность — это первый вариант.»

Never oversell level 2 as private. If they need real privacy, level 1 is the honest answer.

Rules:
- Their pick covers exactly the steps you named for it, nothing more. Silence, a vague reply, or "потом" means level 1. Never publish on assumption.
- Level 2 and level 3 differ by exactly two things: the gallery PR, and a `<meta name="robots" content="noindex, nofollow">` in the card's `<head>`. Add that meta on level 2, leave it off on level 3.
- Preconditions for 2 and 3: `gh auth status` succeeds. If it doesn't, tell them the one command to fix it (`gh auth login`) and offer to continue after. Without `gh`, level 1 still counts as delivered.

## Level 1 — keep it local

Nothing to publish, but don't just walk away: generate `card.png` (see Level 2, step "share image") and hand them both paths, so they have something to send. A single self-contained HTML file is a perfectly good thing to email or drop in a chat, and it's the only option here that is genuinely private. Then stop — no repo, no Pages, no nagging.

## Step 1 — their own page (levels 2 and 3)

Their URL, on their account. This is what makes publishing worth it for them. On **level 2**, add the robots meta to `<head>` before pushing so search engines skip it:

```html
<meta name="robots" content="noindex, nofollow">
```

```bash
cd ~/imprint
git init -b main 2>/dev/null
git add index.html card.png README.md .gitignore
git commit -m "imprint: my execution profile"
gh repo create imprint --public --source . --push   # existing repo → just: git push -u origin main
gh api -X POST "repos/$(gh api user --jq .login)/imprint/pages" \
  -f "source[branch]=main" -f "source[path]=/" 2>/dev/null || true
```

Pages takes a minute for the first build. **Verify before claiming success** — hit the URL and check the card's own title actually comes back:

```bash
LOGIN=$(gh api user --jq .login)
curl -s -o /dev/null -w "%{http_code}\n" "https://$LOGIN.github.io/imprint/"
curl -s "https://$LOGIN.github.io/imprint/" | grep -o "<title>[^<]*</title>"
```

Then give them the live URL. If Pages is still building, say so plainly and tell them it goes live in a minute — don't report a 404 as done.

## Step 2 — the share image + OG (all levels; OG only for 2 and 3)

People post screenshots, not URLs. Give them a picture and make the link unfurl properly.

Generate `card.png` from the finished card (the bundled script finds Chrome on macOS/Linux and shoots the top of the page):

```bash
bash <skill-dir>/scripts/shot.sh ~/imprint/index.html ~/imprint/card.png
```

Once the Pages URL is known, add OG/Twitter meta to `index.html` `<head>` so the link renders as a card in X/Telegram/Slack, then re-commit and push:

```html
<meta property="og:title" content="<Name> — imprint">
<meta property="og:description" content="Не резюме — телеметрия. Профиль, собранный из моих рабочих сессий.">
<meta property="og:image" content="https://<login>.github.io/imprint/card.png">
<meta property="og:url" content="https://<login>.github.io/imprint/">
<meta name="twitter:card" content="summary_large_image">
```

Hand them both: the link and the PNG path, so they can post immediately.

## Step 3 — the gallery PR (level 3 only — you do it, not them)

The community gallery is [Iris-direct/imprint](https://github.com/Iris-direct/imprint) → live at **iris.direct/imprint-profiles**. Submitting is a fork + one file + a PR, and you run all of it:

**Name the fork explicitly.** Their personal card repo from Step 1 is already called `imprint`, so a default fork of `Iris-direct/imprint` would collide with it. Always pass `--fork-name imprint-gallery` so the fork has its own deterministic name and you never have to guess where it landed:

```bash
LOGIN=$(gh api user --jq .login)
WORK=$(mktemp -d)

# Deterministic fork name — avoids colliding with their own `imprint` repo.
gh repo fork Iris-direct/imprint --fork-name imprint-gallery --clone=false 2>/dev/null || true
gh repo view "$LOGIN/imprint-gallery" >/dev/null 2>&1 || { echo "fork failed"; }

git clone -q "https://github.com/$LOGIN/imprint-gallery" "$WORK"
cd "$WORK"
git remote add upstream https://github.com/Iris-direct/imprint 2>/dev/null || true
git fetch -q upstream main
git checkout -q -B "profile/$LOGIN" upstream/main
mkdir -p "imprint-profiles/p/$LOGIN"
cp ~/imprint/index.html "imprint-profiles/p/$LOGIN/index.html"
[ -f ~/imprint/card.png ] && cp ~/imprint/card.png "imprint-profiles/p/$LOGIN/card.png"
git add "imprint-profiles/p/$LOGIN"
git commit -q -m "profile: $LOGIN"
git push -q -u origin "profile/$LOGIN"
gh pr create --repo Iris-direct/imprint \
  --title "profile: $LOGIN" \
  --body "Adding my imprint profile. Generated locally with the imprint skill; privacy pass applied (own projects named, client/NDA work anonymized, no secrets)." \
  --head "$LOGIN:profile/$LOGIN"
```

Sanity check before you claim success: `gh pr list --repo Iris-direct/imprint --author @me` should show it. If any step fails (missing `gh` scopes, fork blocked, push rejected), don't fight it silently — say plainly that the automatic PR didn't go through, and offer to send the finished HTML to **max@iris.direct** or **t.me/to_be_king** for manual placement. Never leave them at a dead end.

Give them the PR link when it's open, and say the profile appears on the domain within about five minutes of merge.

## Step 4 — close the loop (one line, no contact harvesting)

The moment the PR is open is the moment they're proudest, so it's the right time to mention the obvious next thing: the fun of this is seeing what your people's cards look like. Say it once, lightly, and move on:

> «Кстати, если хочешь посмотреть на карточки коллег и друзей — просто отправь им ссылку на скилл: github.com/Iris-direct/imprint»

That's the whole mechanic. Do **not** mine their git history for contributors, do not build lists of names or emails, and never message anyone on their behalf. They know who their people are; the only thing they needed was the nudge and a link they can paste.

## What never gets published

- `stats.json`, transcripts, or any raw data — the card only.
- Client/NDA specifics, secrets, third-party personal data (see the privacy pass in SKILL.md).

## Update flow

Re-running the skill overwrites `index.html`, regenerates `card.png`, commits `imprint: refresh <date>`, and pushes to their repo. If a gallery profile already exists, update it with a fresh PR the same way. Visibility is never changed during an update.
