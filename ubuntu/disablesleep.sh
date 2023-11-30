#!/bin/bash

# Function to disable sleep on Ubuntu.
disableSleepOnUbuntu() {
    # Check if the system is running Ubuntu.
    if [ "$(lsb_release -si)" != "Ubuntu" ]; then
        echo "This function is only applicable for Ubuntu."
        exit 1
    fi

    # Check if the user has root privileges.
    if [ "$EUID" -ne 0 ]; then
        echo "This function requires root privileges. Please run with sudo."
        exit 1
    fi

    # Disable sleep by modifying the systemd sleep target.
    systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

    echo "Sleep disabled successfully."
}

# Usage example for disableSleepOnUbuntu function.

# Call the function to disable sleep on Ubuntu.
disableSleepOnUbuntu