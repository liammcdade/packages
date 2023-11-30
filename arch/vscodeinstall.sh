#!/bin/bash

# Function to install Visual Studio Code on Arch Linux using yay package manager.
install_vscode() {
    # Check if yay is installed
    if ! command -v yay &> /dev/null; then
        echo "yay package manager is not installed. Please install yay first."
        exit 1
    fi

    # Install Visual Studio Code using yay
    yay -S visual-studio-code-bin
}

# Usage example for install_vscode.sh

echo "Installing Visual Studio Code on Arch Linux using yay..."
install_vscode
echo "Visual Studio Code installation completed."