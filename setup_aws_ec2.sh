#!/usr/bin/env bash
# ==============================================================================
# AWS EC2 Setup Script: Git + Docker + Java 17 + Jenkins
# Target OS: Ubuntu 22.04 LTS / 24.04 LTS
# ==============================================================================

set -euo pipefail

echo "=========================================="
echo " Starting AWS EC2 Setup for CI/CD Pipeline"
echo "=========================================="

# 1. Update system packages
echo "--> Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# 2. Install Git and essential dependencies
echo "--> Installing Git and essential utilities..."
sudo apt-get install -y git curl wget ca-certificates apt-transport-https gnupg lsb-release

# 3. Install Docker Engine
echo "--> Installing Docker Engine..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# 4. Install OpenJDK 17 (Required by Jenkins)
echo "--> Installing OpenJDK 17..."
sudo apt-get install -y fontconfig openjdk-17-jre openjdk-17-jdk

# 5. Install Jenkins
echo "--> Adding Jenkins official repository and key..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y jenkins

# 6. Grant Jenkins permission to execute Docker commands without sudo
echo "--> Configuring Docker permissions for Jenkins and ubuntu users..."
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

# Restart services
sudo systemctl restart docker
sudo systemctl enable jenkins
sudo systemctl restart jenkins

echo "============================================================"
echo " Setup Completed Successfully!"
echo "============================================================"
echo "Jenkins Status:"
sudo systemctl status jenkins --no-pager | head -n 10
echo ""
echo "Docker Version:"
docker --version
echo ""
echo "Git Version:"
git --version
echo ""
echo "============================================================"
echo " Jenkins Initial Admin Password:"
echo "============================================================"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
echo "Now access Jenkins at: http://<YOUR_EC2_PUBLIC_IP>:8080"
echo "============================================================"
