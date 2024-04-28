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
cp -rf $SCRIPT_DIR/qtile/ $HOME/dotfiles
cp -rf $SCRIPT_DIR/waybar/ $HOME/dotfiles
cp -f $SCRIPT_DIR/border-1-reverse-less-gaps.conf $HOME/dotfiles/hypr/conf/windows
cp -f $SCRIPT_DIR/rounding-shadow-full-opacity.conf $HOME/dotfiles/hypr/conf/decorations

echo -e "${GREEN}Setup complete.${NC}"
