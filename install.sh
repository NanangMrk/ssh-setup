#!/bin/bash

# ==========================

# Color

# ==========================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear

# ==========================

# Intro

# ==========================

echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}   ███╗   ███╗██████╗ ██╗  ██╗                                             ${NC}"
echo -e "${GREEN}   ████╗ ████║██╔══██╗██║ ██╔╝                                             ${NC}"
echo -e "${GREEN}   ██╔████╔██║██████╔╝█████╔╝                                              ${NC}"
echo -e "${GREEN}   ██║╚██╔╝██║██╔══██╗██╔═██╗                                              ${NC}"
echo -e "${GREEN}   ██║ ╚═╝ ██║██║  ██║██║  ██╗                                             ${NC}"
echo -e "${GREEN}   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝                                             ${NC}"
echo -e "${GREEN}                                                                            ${NC}"
echo -e "${GREEN}========================== SSH CONFIG MRK ==================================${NC}"
echo -e "${GREEN}      Auto SSH Configuration & Root Access Installer                       ${NC}"
echo -e "${GREEN}       By NanangMrk - https://github.com/NanangMrk                         ${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo ""
echo -e "${YELLOW}This script will:${NC}"
echo -e "${GREEN}✓ Update package repository${NC}"
echo -e "${GREEN}✓ Enable SSH Root Login${NC}"
echo -e "${GREEN}✓ Enable Password Authentication${NC}"
echo -e "${GREEN}✓ Set Root Password${NC}"
echo -e "${GREEN}✓ Restart SSH Service${NC}"
echo ""
echo -e "${YELLOW}Do you want to continue? (y/n)${NC}"
read confirmation

if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
echo -e "${RED}Installation cancelled.${NC}"
exit 1
fi

# ==========================

# Root Check

# ==========================

if [ "$EUID" -ne 0 ]; then
echo -e "${RED}Please run this script as root!${NC}"
exit 1
fi

echo ""
echo -e "${GREEN}[1/5] Updating packages...${NC}"
apt update -y

echo ""
echo -e "${GREEN}[2/5] Backup SSH configuration...${NC}"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

echo ""
echo -e "${GREEN}[3/5] Enabling Root Login...${NC}"
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

echo ""
echo -e "${GREEN}[4/5] Enabling Password Authentication...${NC}"
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

grep -q "^PasswordAuthentication" /etc/ssh/sshd_config || 
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

echo ""
echo -e "${GREEN}[5/5] Setting Root Password...${NC}"
echo "root:nanangmrk" | chpasswd

echo ""
echo -e "${GREEN}Restarting SSH Service...${NC}"
systemctl restart ssh

echo ""
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN}                        INSTALLATION COMPLETED                             ${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${GREEN} SSH Root Login        : ENABLED                                           ${NC}"
echo -e "${GREEN} Password Auth         : ENABLED                                           ${NC}"
echo -e "${GREEN} Root Password         : nanangmrk                                         ${NC}"
echo -e "${GREEN}============================================================================${NC}"
echo -e "${YELLOW}Server is ready to use.${NC}"
echo -e "${GREEN}GitHub: https://github.com/NanangMrk${NC}"
echo -e "${GREEN}============================================================================${NC}"
