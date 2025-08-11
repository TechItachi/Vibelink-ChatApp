#!/bin/bash

# VPS Deployment Script for Chat App
echo "🚀 Deploying Chat App to VPS..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
if ! command -v docker &> /dev/null; then
    echo "📦 Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
fi

# Install Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "📦 Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Create app directory
mkdir -p ~/chatapp
cd ~/chatapp

# Clone your repository (replace with your actual repo URL)
# git clone https://github.com/yourusername/chatapp.git .

# Copy your files here or clone from git
echo "📁 Setting up application files..."

# Create .env file for backend
cat > backend/.env << EOF
PORT=5001
MONGODB_URI=your_mongodb_connection_string
JWT_SECRET=your_super_secret_key
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
EOF

# Build and run with Docker Compose
echo "🐳 Building and starting containers..."
docker-compose up --build -d

echo "✅ Deployment complete!"
echo "🌐 Frontend: http://your-server-ip:5173"
echo "🔧 Backend: http://your-server-ip:5001"
echo ""
echo "📋 To view logs: docker-compose logs -f"
echo "🛑 To stop: docker-compose down"
echo "🔄 To restart: docker-compose restart"
