#!/bin/bash

# Function to install KDE on Ubuntu.
installKDE() {
    # Check if KDE is already installed.
    if [ -x "$(command -v plasma-desktop)" ]; then
        echo "KDE is already installed."
    else
        # Update the package lists.
        sudo apt update

        # Install KDE Plasma desktop.
        sudo apt install kubuntu-desktop

        # Prompt to choose the display manager.
        sudo dpkg-reconfigure sddm

        echo "KDE installed successfully."
    fi
}

# Usage example for installKDE function.
installKDE