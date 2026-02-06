#!/bin/bash

# Script to install packages from a list using yay
# Usage: ./install_packages.sh <package_list_file>

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if a package list file was provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No package list file provided${NC}"
    echo "Usage: $0 <package_list_file>"
    exit 1
fi

PKGLIST="$1"

# Check if the package list file exists
if [ ! -f "$PKGLIST" ]; then
    echo -e "${RED}Error: File '$PKGLIST' not found${NC}"
    exit 1
fi

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}yay is not installed. Installing yay...${NC}"

    # Check if git is installed (needed to build yay)
    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW}Installing git (required for yay)...${NC}"
        sudo pacman -S --needed --noconfirm git base-devel
    fi

    # Install yay
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd
    rm -rf "$TEMP_DIR"

    echo -e "${GREEN}yay installed successfully${NC}"
else
    echo -e "${GREEN}yay is already installed${NC}"
fi

# Count total packages
TOTAL_PKGS=$(wc -l < "$PKGLIST")
echo -e "${YELLOW}Found $TOTAL_PKGS packages to install${NC}"

# Install packages
echo -e "${YELLOW}Starting package installation...${NC}"
echo ""

# Using yay with --needed flag to skip already installed packages
# --noconfirm for non-interactive installation (remove if you want confirmations)
yay -S --needed - < "$PKGLIST"

echo ""
echo -e "${GREEN}Package installation complete!${NC}"
