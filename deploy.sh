#!/bin/bash

echo "▶ Pulling latest code..."
cd /home/ubuntu/test || { echo "Directory not found! Exiting."; exit 1; }

# Pull latest code
git pull origin main

# Install dependencies
echo "▶ Installing dependencies..."
npm install --production

# Build (optional)
echo "▶ Building app..."
npm run build || echo "No build step"

# Restart app
echo "▶ Restarting app with PM2..."
pm2 restart your-app || pm2 start npm --name "your-app" -- start

echo "✅ Deployment complete."


