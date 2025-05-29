#!/bin/bash
set -e

# Auto-detect the directory this script is in (i.e., the app root)
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="$(basename "$APP_DIR")"

echo "▶ Starting deployment for $APP_NAME"
echo "▶ APP_DIR: $APP_DIR"

# Ensure NVM is installed
if [ -d "$HOME/.nvm" ]; then
  echo "▶ NVM is already installed."
else
  echo "▶ Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM into current shell
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Use latest LTS version of Node
nvm install --lts
nvm use --lts

# Ensure PM2 is available
export PATH="$PATH:$(npm bin -g)"
if ! command -v pm2 &>/dev/null; then
  echo "▶ Installing PM2 globally..."
  npm install -g pm2
fi

# Move into the app directory
cd "$APP_DIR"

echo "▶ Installing dependencies..."
npm install --production

echo "▶ Building app (if build script is defined)..."
npm run build || echo "⚠️ No build script found or skipped."

echo "▶ Restarting app with PM2..."
pm2 restart "$APP_NAME" || pm2 start npm --name "$APP_NAME" -- start

echo "✅ Deployment for $APP_NAME completed."
