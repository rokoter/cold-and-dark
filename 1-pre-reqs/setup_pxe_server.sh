#!/bin/bash
# PXE Server Setup Script for Ubuntu 22.04
# This script automates the installation and configuration of a PXE boot server

# Variables
PXE_IP="192.168.15.1"
TFTP_ROOT="/var/lib/tftpboot"
WEB_ROOT="/var/www/html/netboot"

# Update and install necessary packages
echo "Updating system and installing required packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y dnsmasq syslinux pxelinux nginx wget

# Configure dnsmasq
echo "Configuring dnsmasq..."
echo "interface=eth0
dhcp-range=192.168.15.100,192.168.15.200,12h
dhcp-boot=pxelinux.0
enable-tftp
tftp-root=$TFTP_ROOT" | sudo tee /etc/dnsmasq.conf

# Restart dnsmasq
sudo systemctl restart dnsmasq

# Set up TFTP directory
echo "Setting up TFTP server..."
sudo mkdir -p $TFTP_ROOT
sudo chmod -R 777 $TFTP_ROOT
sudo cp /usr/lib/PXELINUX/pxelinux.0 $TFTP_ROOT/
sudo cp -r /usr/lib/syslinux/modules/bios/* $TFTP_ROOT/

# Set up Web server
echo "Setting up Web server for Netboot files..."
sudo mkdir -p $WEB_ROOT
cd $WEB_ROOT
sudo wget http://archive.ubuntu.com/ubuntu/dists/jammy/main/installer-amd64/current/legacy-images/netboot/netboot.tar.gz
sudo tar -xvzf netboot.tar.gz
sudo rm netboot.tar.gz

# Restart nginx
sudo systemctl restart nginx

echo "PXE server setup complete. Ready for PXE booting!"

