#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Claude Code Config Setup ==="

# Check dependencies
missing=()
for cmd in git jq; do
  if ! command -v "$cmd" &>/dev/null; then
    missing+=("$cmd")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing required tools: ${missing[*]}"
  echo "Installing..."
  if command -v apt-get &>/dev/null; then
    sudo apt-get update -qq && sudo apt-get install -y -qq "${missing[@]}"
  elif command -v brew &>/dev/null; then
    brew install "${missing[@]}"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --noconfirm "${missing[@]}"
  else
    echo "ERROR: Cannot auto-install. Please install manually: ${missing[*]}"
    exit 1
  fi
fi

echo "[ok] git $(git --version | cut -d' ' -f3)"
echo "[ok] jq $(jq --version)"

# Create settings.json from template if it doesn't exist
if [ ! -f "$SCRIPT_DIR/settings.json" ]; then
  echo ""
  echo "No settings.json found. Creating from template..."
  cp "$SCRIPT_DIR/settings.json.template" "$SCRIPT_DIR/settings.json"

  read -rp "ANTHROPIC_AUTH_TOKEN: " auth_token
  read -rp "ANTHROPIC_API_KEY (leave empty if not needed): " api_key

  jq --arg token "$auth_token" --arg key "$api_key" \
    '.env.ANTHROPIC_AUTH_TOKEN = $token | .env.ANTHROPIC_API_KEY = $key' \
    "$SCRIPT_DIR/settings.json" > "$SCRIPT_DIR/settings.json.tmp" \
    && mv "$SCRIPT_DIR/settings.json.tmp" "$SCRIPT_DIR/settings.json"

  chmod 600 "$SCRIPT_DIR/settings.json"
  echo "[ok] settings.json created (permissions: 600)"
else
  echo "[ok] settings.json already exists"
fi

# Ensure required directories exist (gitignored, needed at runtime)
for dir in projects debug cache backups downloads file-history ide plans session-env shell-snapshots memory homunculus; do
  mkdir -p "$SCRIPT_DIR/$dir"
done
echo "[ok] Runtime directories created"

# Install plugins if plugin root is set
if command -v claude &>/dev/null; then
  echo ""
  echo "Claude CLI detected. You can install plugins with:"
  echo "  claude plugins install"
fi

echo ""
echo "=== Setup complete ==="
