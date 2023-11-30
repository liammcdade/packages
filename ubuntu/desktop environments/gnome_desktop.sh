#!/bin/bash

# Function to install GNOME on Ubuntu.
install_gnome() {
    # Check if GNOME is already installed.
    if [ -x "$(command -v gnome-session)" ]; then
        echo "GNOME is already installed."
    else
        # Update the package lists.
        sudo apt update

        # Install GNOME.
        sudo apt install gnome-session gnome-shell

        # Check if GNOME installation was successful.
        if [ -x "$(command -v gnome-session)" ]; then
            echo "GNOME has been successfully installed."
        else
            echo "Failed to install GNOME."
        fi
    fi
}

# Usage example for install_gnome.sh

# Call the install_gnome function.
install_gnome