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

## The offer (make it once, at peak delight)

Right after they've seen the card and are happy with it, offer the whole thing in one question. Say plainly what will happen, then wait for a clear yes:

> «Могу сделать её живой ссылкой: подниму тебе репозиторий `imprint` с GitHub Pages — получится `https://<твой-логин>.github.io/imprint/`, плюс картинка для репоста. И, если хочешь, добавлю в общую галерею iris.direct/imprint-profiles — PR отправлю сам. Делаем?»

Rules:
- One explicit yes covers the steps you named. A vague reply, silence, or "потом" means everything stays local. Never publish on assumption.
- If they want the personal page but NOT the gallery (or the reverse), honour exactly that — the two are separate.
- Preconditions: `gh auth status` succeeds. If it doesn't, tell them the one command to fix it (`gh auth login`) and offer to continue after. Without `gh`, the local card still counts as delivered.

## Step 1 — their own page (their value, do this first)

Their URL, on their account. This is what makes publishing worth it for them.

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

## Step 2 — the share image + OG

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

## Step 3 — the gallery PR (you do it, not them)

The community gallery is [Iris-direct/imprint](https://github.com/Iris-direct/imprint) → live at **iris.direct/imprint-profiles**. Submitting is a fork + one file + a PR, and you run all of it:

```bash
LOGIN=$(gh api user --jq .login)
WORK=$(mktemp -d)
gh repo fork Iris-direct/imprint --clone=false 2>/dev/null || true   # no-op if the fork exists
git clone -q "https://github.com/$LOGIN/imprint-gallery-fork" "$WORK" 2>/dev/null || \
  git clone -q "https://github.com/$LOGIN/imprint" "$WORK"
cd "$WORK"
git remote add upstream https://github.com/Iris-direct/imprint 2>/dev/null || true
git fetch -q upstream main && git checkout -q -B "profile/$LOGIN" upstream/main
mkdir -p "imprint-profiles/p/$LOGIN"
cp ~/imprint/index.html "imprint-profiles/p/$LOGIN/index.html"
git add "imprint-profiles/p/$LOGIN/index.html"
git commit -q -m "profile: $LOGIN"
git push -q -u origin "profile/$LOGIN"
gh pr create --repo Iris-direct/imprint \
  --title "profile: $LOGIN" \
  --body "Adding my imprint profile. Generated locally with the imprint skill; privacy pass applied (own projects named, client/NDA work anonymized, no secrets)." \
  --head "$LOGIN:profile/$LOGIN"
```

Naming collision note: the person's personal repo is also called `imprint`, so the fork may land under a different name — resolve the actual fork URL from `gh repo fork` output rather than assuming. If the fork flow fails for any reason, fall back gracefully: tell them the PR couldn't be opened automatically, and offer to send the finished HTML to **max@iris.direct** or **t.me/to_be_king** for manual placement. Never leave them at a dead end.

Give them the PR link when it's open, and say the profile appears on the domain within about five minutes of merge.

## What never gets published

- `stats.json`, transcripts, or any raw data — the card only.
- Client/NDA specifics, secrets, third-party personal data (see the privacy pass in SKILL.md).

## Update flow

Re-running the skill overwrites `index.html`, regenerates `card.png`, commits `imprint: refresh <date>`, and pushes to their repo. If a gallery profile already exists, update it with a fresh PR the same way. Visibility is never changed during an update.
