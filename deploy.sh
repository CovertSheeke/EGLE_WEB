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
sudo docker stop egle-nginx-demo egle-redis-demo egle-streamlit-demo 2>/dev/null || true
sudo docker rm egle-nginx-demo egle-redis-demo egle-streamlit-demo 2>/dev/null || true

echo "Pulling Docker images from DockerHub..."
sudo docker pull nginx:alpine
sudo docker pull redis:alpine
sudo docker pull python:3.11-alpine

echo "Starting Redis database container..."
sudo docker run -d \
    --name egle-redis-demo \
    -p 6379:6379 \
    --restart unless-stopped \
    redis:alpine

echo "Starting Nginx web server container..."
sudo docker run -d \
    --name egle-nginx-demo \
    -p 8080:80 \
    --restart unless-stopped \
    nginx:alpine

echo "Starting Streamlit app container..."
sudo docker run -d \
    --name egle-streamlit-demo \
    -p 8501:8501 \
    --restart unless-stopped \
    python:3.11-alpine \
    sh -c "pip install streamlit && streamlit hello --server.port=8501 --server.address=0.0.0.0"

echo "Verifying containers are running..."
sudo docker ps | grep egle-
sudo docker exec egle-redis-demo redis-cli ping

echo "Reloading nginx..."
systemctl reload nginx

echo "✅ Deployment complete!"
echo "🐳 Docker containers running:"
echo "   - Redis database on port 6379"
echo "   - Nginx web server on port 8080"
echo "   - Streamlit app on port 8501"
echo "📱 Main website running on port 80"
EOF

echo "🚀 Website and Docker container deployed successfully!"