#!/bin/bash

# Function to update Ubuntu system.
# This function uses the 'apt-get' command to update the system packages.

updateUbuntu() {
    sudo apt-get update  # Update the package lists.
    sudo apt-get upgrade -y  # Upgrade the installed packages.
    sudo apt-get dist-upgrade -y  # Upgrade the distribution packages.
    sudo apt-get autoremove -y  # Remove unnecessary packages.
    sudo apt-get autoclean -y  # Clean up the package cache.
}

# Usage example for updateUbuntu.sh

echo "Updating Ubuntu..."
updateUbuntu
echo "Ubuntu update completed."