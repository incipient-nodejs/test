# #!/bin/bash

# echo "▶ Pulling latest code..."
# cd /home/ubuntu/test || { echo "Directory not found! Exiting."; exit 1; }

# # Pull latest code
# git pull origin main

# # Install dependencies
# echo "▶ Installing dependencies..."
# npm install --production

# # Build (optional)
# echo "▶ Building app..."
# npm run build || echo "No build step"

# # Restart app
# echo "▶ Restarting app with PM2..."
# pm2 restart your-app || pm2 start npm --name "your-app" -- start

# echo "✅ Deployment complete."


#!/bin/bash

APP_DIR="/home/ubuntu/test"
NODE_VERSION="lts/*"  # change to specific version like "18" if needed

echo "▶ Starting deployment..."

# Ensure NVM is installed
if [ -d "$HOME/.nvm" ]; then
  echo "▶ NVM is already installed."
else
  echo "▶ NVM not found. Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

if ! command -v nvm &>/dev/null; then
  echo "❌ NVM installation failed. Exiting."
  exit 1
fi

# Install and use Node
echo "▶ Installing Node.js version: $NODE_VERSION"
nvm install $NODE_VERSION
nvm use $NODE_VERSION

# Ensure PM2 is installed
if ! command -v pm2 &>/dev/null; then
  echo "▶ PM2 not found. Installing PM2 globally..."
  npm install -g pm2
else
  echo "▶ PM2 is already installed."
fi

# Navigate to app directory
echo "▶ Pulling latest code..."
cd "$APP_DIR" || { echo "❌ Directory $APP_DIR not found! Exiting."; exit 1; }

git pull origin main || { echo "❌ Git pull failed! Exiting."; exit 1; }

echo "▶ Installing dependencies..."
npm install || { echo "❌ npm install failed! Exiting."; exit 1; }

# echo "▶ Building app..."
# npm run build || echo "⚠️ Build step skipped or failed."

echo "▶ Restarting app with PM2..."
pm2 restart your-app || pm2 start npm --name "your-app" -- start

echo "✅ Deployment complete."


