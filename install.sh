#!/bin/bash
# Agent Foundry — one-line installer for macOS (Apple Silicon).
#
#   curl -fsSL https://raw.githubusercontent.com/Shai-2002/agent-foundry-app/main/install.sh | bash
#
# Downloads the app, installs it to /Applications, and clears the download
# "quarantine" flag so it opens with no Gatekeeper warning. No Docker, no fee.
set -euo pipefail

APP="Agent Foundry.app"
VERSION="v0.1.0"
DMG_URL="https://github.com/Shai-2002/agent-foundry-app/releases/download/${VERSION}/AgentFoundry_${VERSION#v}_aarch64.dmg"

MOUNT=""
TMP="$(mktemp -d)"
cleanup() {
  [ -n "$MOUNT" ] && hdiutil detach "$MOUNT" >/dev/null 2>&1 || true
  rm -rf "$TMP"
}
trap cleanup EXIT

if [ "$(uname -m)" != "arm64" ]; then
  echo "This build is for Apple Silicon Macs (M1/M2/M3/M4). Yours reports $(uname -m)." >&2
  exit 1
fi

echo "-> Downloading Agent Foundry ${VERSION} ..."
curl -fsSL "$DMG_URL" -o "$TMP/af.dmg"

echo "-> Installing to /Applications ..."
MOUNT="$(hdiutil attach "$TMP/af.dmg" -nobrowse -readonly | grep -o '/Volumes/.*$' | tail -1)"
rm -rf "/Applications/${APP}"
cp -R "${MOUNT}/${APP}" /Applications/
hdiutil detach "$MOUNT" >/dev/null 2>&1 || true
MOUNT=""

echo "-> Clearing the download-quarantine flag ..."
xattr -dr com.apple.quarantine "/Applications/${APP}" 2>/dev/null || true

echo "Installed. Opening Agent Foundry ..."
open "/Applications/${APP}"
