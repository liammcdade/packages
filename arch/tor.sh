#!/bin/bash

# Function to install Tor on Arch Linux.
install_tor() {
    # Check if Tor is already installed.
    if command -v tor &> /dev/null; then
        echo "Tor is already installed."
    else
        # Update the package manager and install Tor.
        sudo pacman -Sy tor

        # Start the Tor service.
        sudo systemctl start tor

        # Enable the Tor service to start on boot.
        sudo systemctl enable tor

        echo "Tor has been installed successfully."
    fi
}

# Usage example for install_tor function.
install_tor