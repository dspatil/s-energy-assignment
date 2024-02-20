#!/bin/bash

# Update package repositories
apt-get update

# Install Apache web server
apt-get install -y apache2

# Start Apache service
systemctl start apache2

# Enable Apache service to start on boot
systemctl enable apache2
