#!/bin/bash

# ==========================================

# SSH CONFIG MRK

# By NanangMrk

# https://github.com/NanangMrk

# ==========================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear

echo -e "${GREEN}====================================================================${NC}"
echo -e "${GREEN}   _   _    _    _   _    _    _   _  ____      __  __ ____  _  __ ${NC}"
echo -e "${GREEN}  | \ | |  / \  | \ | |  / \  | \ | |/ ***|    |  \/  |  _ \| |/ / ${NC}"
echo -e "${GREEN}  |  \| | / _ \ |  \| | / _ \ |  \| | |  _     | |\/| | |*) | ' /  ${NC}"
echo -e "${GREEN}  | |\  |/ ___ \| |\  |/ ___ \| |\  | |*| |    | |  | |  _ <| . \  ${NC}"
echo -e "${GREEN}  |*| \*/*/   \*\*| \*/*/   \*\*| \*|\****|    |*|  |*|*| \*\*|\_\ ${NC}"
echo -e "${GREEN}                                                                    ${NC}"
echo -e "${GREEN}======================= SSH CONFIG MRK =============================${NC}"
echo -e "${GREEN}              Auto SSH Configuration Installer                     ${NC}"
echo -e "${GREEN}          By NanangMrk - https://github.com/NanangMrk              ${NC}"
echo -e "${GREEN}====================================================================${NC}"
echo ""

echo -e "${YELLOW}This script will:${NC}"
echo -e "${GREEN}[OK] Update package repository${NC}"
echo -e "${GREEN}[OK] Install OpenSSH Server${NC}"
echo -e "${GREEN}[OK] Enable SSH Root Login${NC}"
echo -e "${GREEN}[OK] Enable Password Authentication${NC}"
echo -e "${GREEN}[OK] Set Root Password${NC}"
echo -e "${GREEN}[OK] Enable SSH Service${NC}"
echo -e "${GREEN}[OK] Restart SSH Service${NC}"
echo ""

read -p "Do you want to continue? (y/n): " confirmation

if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
echo -e "${RED}Installation cancelled.${NC}"
exit 1
fi

if [ "$EUID" -ne 0 ]; then
echo -e "${RED}Please run this script as root!${NC}"
exit 1
fi

echo ""
echo -e "${GREEN}[1/7] Updating package repository...${NC}"
apt update -y

echo ""
echo -e "${GREEN}[2/7] Installing OpenSSH Server...${NC}"
apt install -y openssh-server

echo ""
echo -e "${GREEN}[3/7] Backing up SSH configuration...${NC}"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo ""
echo -e "${GREEN}[4/7] Enabling Root Login...${NC}"

if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
elif grep -q "^#PermitRootLogin" /etc/ssh/sshd_config; then
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
else
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
fi

echo ""
echo -e "${GREEN}[5/7] Enabling Password Authentication...${NC}"

if grep -q "^PasswordAuthentication" /etc/ssh/sshd_config; then
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
elif grep -q "^#PasswordAuthentication" /etc/ssh/sshd_config; then
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
else
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
fi

echo ""
echo -e "${GREEN}[6/7] Setting Root Password...${NC}"
echo "root:nanangmrk" | chpasswd

echo ""
echo -e "${GREEN}[7/7] Enabling and Restarting SSH Service...${NC}"

systemctl enable ssh
systemctl restart ssh

echo ""
echo -e "${GREEN}Checking SSH Service Status...${NC}"

if systemctl is-active --quiet ssh; then
SSH_STATUS="ACTIVE"
else
SSH_STATUS="FAILED"
fi

echo ""
echo -e "${GREEN}====================================================================${NC}"
echo -e "${GREEN}                    INSTALLATION COMPLETED                          ${NC}"
echo -e "${GREEN}====================================================================${NC}"
echo -e "${GREEN} SSH Service      : ${SSH_STATUS}${NC}"
echo -e "${GREEN} Root Login       : ENABLED${NC}"
echo -e "${GREEN} Password Auth    : ENABLED${NC}"
echo -e "${GREEN} Username         : root${NC}"
echo -e "${GREEN} Password         : nanangmrk${NC}"
echo -e "${GREEN}====================================================================${NC}"
echo -e "${YELLOW}You can now login using:${NC}"
echo -e "${GREEN}ssh root@SERVER_IP${NC}"
echo -e "${GREEN}====================================================================${NC}"
echo -e "${GREEN}GitHub: https://github.com/NanangMrk${NC}"
echo -e "${GREEN}====================================================================${NC}"
