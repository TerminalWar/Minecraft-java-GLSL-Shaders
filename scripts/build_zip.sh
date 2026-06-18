#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"
rm -f SLGL-Mobile-Vibrant.zip
zip -qr SLGL-Mobile-Vibrant.zip SLGL-Mobile-Vibrant
printf 'Created %s/SLGL-Mobile-Vibrant.zip\n' "$ROOT_DIR"
