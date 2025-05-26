#!/bin/bash

# Update system
dnf update -y

# Install EPEL repository
dnf install -y epel-release

# Install basic utilities
dnf install -y wget curl vim git

# Install Python 3.9
dnf install -y python39
alternatives --set python3 /usr/bin/python3.9
# dnf install -y python39-pip  # Seems to be failing
dnf install -y python3-pip

# Install Docker
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

# Install Terraform
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf install -y terraform

# Configure firewall
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload

# Verify installations
echo "Installed versions:"
python3 --version
pip3 --version
git --version
docker --version
terraform --version 
