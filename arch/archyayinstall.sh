#!/bin/bash

# Function to install yay on Arch Linux.
install_yay() {
    # Check if yay is already installed.
    if command -v yay &> /dev/null; then
        echo "yay is already installed."
        return 0
    fi

    # Install yay using git and make.
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm

    # Check if installation was successful.
    if command -v yay &> /dev/null; then
        echo "yay installed successfully."
    else
        echo "Failed to install yay."
    fi
}

# Usage example for install_yay.sh

# Call the install_yay function.
install_yay