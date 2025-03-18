# PXE Server Setup for Ubuntu 22.04

This script automates the installation and configuration of a PXE boot server on Ubuntu 22.04.

## Installation Instructions

### 1. Download the script
Run the following command to download the setup script from GitHub:

```bash
wget -O setup_pxe_server.sh https://raw.githubusercontent.com/rokoter/cold-and-dark/main/1-pre-reqs/setup_pxe_server.sh
```

### 2. Make the script executable

```bash
chmod +x setup_pxe_server.sh
```

### 3. Run the script as root

```bash
sudo ./setup_pxe_server.sh
```

## What This Script Does
- Installs required packages (`dnsmasq`, `syslinux`, `pxelinux`, `nginx`, `wget`).
- Configures `dnsmasq` for PXE booting.
- Sets up a TFTP server and populates it with necessary PXE boot files.
- Sets up a simple web server (`nginx`) to serve Ubuntu netboot files.
- Downloads Ubuntu netboot files automatically.

## Logs and Troubleshooting
If the PXE boot process fails, check the logs:

```bash
sudo journalctl -u dnsmasq --no-pager | tail -20
sudo journalctl -u nginx --no-pager | tail -20
```

For debugging, restart services if needed:

```bash
sudo systemctl restart dnsmasq
sudo systemctl restart nginx
```

## Next Steps
- Configure an automated installation process using Preseed or Cloud-init.
- Automate node registration with Ansible.

This completes the basic PXE setup. 🚀

