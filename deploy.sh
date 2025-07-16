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

echo "Installing Docker (if not already installed)..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
fi

echo "Stopping existing Docker containers..."
sudo docker stop egle-nginx-demo 2>/dev/null || true
sudo docker rm egle-nginx-demo 2>/dev/null || true

echo "Pulling latest nginx image from DockerHub..."
sudo docker pull nginx:alpine

echo "Starting real Docker container from DockerHub..."
sudo docker run -d \
    --name egle-nginx-demo \
    -p 8080:80 \
    --restart unless-stopped \
    nginx:alpine

echo "Verifying container is running..."
sudo docker ps | grep egle-nginx-demo

echo "Reloading nginx..."
systemctl reload nginx

echo "✅ Deployment complete!"
echo "🐳 Docker container running on port 8080"
echo "📱 Main website running on port 80"
EOF

echo "🚀 Website and Docker container deployed successfully!"