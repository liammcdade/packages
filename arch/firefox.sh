#!/bin/bash

# Function to install Firefox on Arch Linux.
install_firefox() {
    # Check if the user is running the script with root privileges.
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root."
        exit 1
    fi

    # Update the package manager and install Firefox.
    pacman -Syu --noconfirm firefox

    # Check if the installation was successful.
    if [ $? -eq 0 ]; then
        echo "Firefox has been installed successfully."
    else
        echo "Failed to install Firefox."
    fi
}

# Usage example for install_firefox.sh

# Call the install_firefox function to install Firefox.
install_firefox