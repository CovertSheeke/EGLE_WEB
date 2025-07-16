#!/bin/bash
# deploy.sh

echo "Deploying to personal_hetzner_cloud..."
ssh -T personal_hetzner_cloud << 'EOF'
echo "Updating repository..."
cd /tmp/manual-website
git pull origin main

echo "Copying files..."
cp -r site/* /var/www/html/

echo "Setting permissions..."
chown -R www-data:www-data /var/www/html

echo "Reloading nginx..."
systemctl reload nginx

echo "✅ Deployment complete!"
EOF

echo "🚀 Website deployed successfully!"