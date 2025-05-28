# #!/bin/bash

# echo "▶ Pulling latest code..."
# cd /home/ec2-user/your-app

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

echo "▶ Starting deployment..."

# Load NVM (ensure this path matches your setup)
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "▶ Loading NVM..."
  source "$NVM_DIR/nvm.sh"
else
  echo "❌ NVM not found at $NVM_DIR. Exiting."
  exit 1
fi

# Use correct Node version (optional, but recommended)
NODE_VERSION="24"  # change to your required version
nvm install $NODE_VERSION
nvm use $NODE_VERSION

echo "▶ Pulling latest code..."
cd /home/ec2-user/your-app || exit 1

git pull origin main || exit 1

echo "▶ Installing dependencies..."
npm install --production || exit 1

echo "▶ Building app..."
npm run build || echo "No build step"

echo "▶ Restarting app with PM2..."
pm2 restart your-app || pm2 start npm --name "your-app" -- start

echo "✅ Deployment complete."
