#!/bin/bash

# Function to install Chrome on Arch Linux.
install_chrome() {
    # Check if the system is Arch Linux.
    if [ "$(uname -r | grep -o 'ARCH')" = "ARCH" ]; then
        # Update the package manager.
        sudo pacman -Syu

        # Install Chrome.
        sudo pacman -S google-chrome

        echo "Chrome installed successfully."
    else
        echo "This function is only supported on Arch Linux."
        exit 1
    fi
}

# Usage example for install_chrome.sh

# Call the install_chrome function.
install_chrome