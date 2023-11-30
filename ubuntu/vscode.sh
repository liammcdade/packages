#!/bin/bash

# Function to install Visual Studio Code on Ubuntu.
install_vscode_ubuntu() {
    # Check if Visual Studio Code is already installed.
    if command -v code >/dev/null 2>&1; then
        echo "Visual Studio Code is already installed."
        exit 0
    fi

    # Import the Microsoft GPG key.
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

    # Add the Visual Studio Code repository.
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list

    # Update the package list.
    sudo apt update

    # Install Visual Studio Code.
    sudo apt install code

    # Verify the installation.
    if command -v code >/dev/null 2>&1; then
        echo "Visual Studio Code has been successfully installed."
    else
        echo "Installation of Visual Studio Code failed."
    fi
}

# Usage example for install_vscode_ubuntu function.
install_vscode_ubuntu