#!/bin/bash

# Variables
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Upgrade system
echo -e "${YELLOW}Updating system...${NC}"
sudo pacman -Syu

# Configure pacman
cd $SCRIPT_DIR
sudo cp -f pacman.conf /etc/pacman.conf

# Install GRUB theme
cd $SCRIPT_DIR

echo -e "${YELLOW}Copying default grub config...${NC}"
sudo cp -f grub /etc/default/grub

echo -e "${YELLOW}Cloning GRUB theme repository...${NC}"
git clone https://github.com/sandesh236/sleek--themes.git
cd sleek--themes/Sleek\ theme-dark

echo -e "${YELLOW}Installing GRUB theme...${NC}"
chmod +x install.sh
sudo ./install.sh

# Detect Windows boot
sudo pacman -S os-prober
echo -e "${YELLOW}Make GRUB config...${NC}"
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Create Downloads folder
echo -e "${YELLOW}Creating Downloads folder...${NC}"
mkdir $HOME/Downloads/
cd $HOME/Downloads/

# Clone repository
echo -e "${YELLOW}Cloning dotfiles repository...${NC}"
git clone https://gitlab.com/stephan-raabe/dotfiles.git
cd $HOME/Downloads/dotfiles/

# Install dotfiles
echo -e "${YELLOW}Installing dotfiles...${NC}\n${RED}DO NOT REBOOT${NC}"
./install.sh

# Copy configurations
echo -e "${YELLOW}Copying configurations...${NC}"
cd $SCRIPT_DIR
cp -rf qtile/ $HOME/dotfiles
cp -rf waybar/ $HOME/dotfiles
cp -f border-1-reverse-less-gaps.conf $HOME/dotfiles/hypr/conf/windows
cp -f rounding-shadow-full-opacity.conf $HOME/dotfiles/hypr/conf/decorations

# Installing fonts
echo -e "${YELLOW}Installing fonts...${NC}"
yay -Syu noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
echo -e "${YELLOW}Installing apps...${NC}"
yay -Syu vesktop-bin
echo -e "${YELLOW}Remove unwanted apps...${NC}"
yay -R dolphin kitty pacseek

echo -e "${GREEN}Setup complete${NC}\n${YELLOW}Reboot now${NC}"
