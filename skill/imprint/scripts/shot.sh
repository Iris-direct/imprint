#!/usr/bin/env bash
# imprint: render a share image (PNG) from a finished card.
# usage: shot.sh <card.html> <out.png> [width] [height]
# People post pictures, not URLs — this is what actually spreads the card.
set -euo pipefail

CARD="${1:?usage: shot.sh <card.html> <out.png> [width] [height]}"
OUT="${2:?usage: shot.sh <card.html> <out.png> [width] [height]}"
W="${3:-1200}"
H="${4:-630}"   # OG aspect ratio: the link unfurls as a big card

[ -f "$CARD" ] || { echo "shot.sh: no such card: $CARD" >&2; exit 1; }

# Find a Chrome/Chromium binary across macOS and Linux.
CHROME=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser" \
  google-chrome google-chrome-stable chromium chromium-browser brave-browser
do
  if [ -x "$c" ] 2>/dev/null; then CHROME="$c"; break; fi
  if command -v "$c" >/dev/null 2>&1; then CHROME="$(command -v "$c")"; break; fi
done

if [ -z "$CHROME" ]; then
  echo "shot.sh: no Chrome/Chromium found — skipping the share image." >&2
  echo "shot.sh: the card itself is fine; install Chrome to get card.png." >&2
  exit 2
fi

# Absolute file:// URL so relative assets resolve.
case "$CARD" in
  /*) ABS="$CARD" ;;
  *)  ABS="$(cd "$(dirname "$CARD")" && pwd)/$(basename "$CARD")" ;;
esac

mkdir -p "$(dirname "$OUT")"

# --virtual-time-budget lets webfonts and inline scripts (charts) paint first.
"$CHROME" --headless=new --disable-gpu --hide-scrollbars \
  --force-device-scale-factor=2 \
  --virtual-time-budget=4000 \
  --window-size="${W},${H}" \
  --screenshot="$OUT" \
  "file://${ABS}" >/dev/null 2>&1 || true

if [ -s "$OUT" ]; then
  echo "shot.sh: wrote $OUT (${W}x${H} @2x)"
else
  echo "shot.sh: screenshot failed — card is unaffected, just no share image." >&2
  exit 2
fi
