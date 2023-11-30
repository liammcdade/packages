#!/bin/bash

# Function to install and mine XMR in Ubuntu.
installAndMineXMR() {
    # Step 1: Install dependencies
    echo "Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y build-essential cmake libuv1-dev libssl-dev libhwloc-dev

    # Step 2: Download and extract XMRig source code
    echo "Downloading XMRig source code..."
    wget https://github.com/xmrig/xmrig/archive/refs/tags/v6.15.2.tar.gz
    tar -xf v6.15.2.tar.gz

    # Step 3: Build XMRig
    echo "Building XMRig..."
    cd xmrig-6.15.2
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)

    # Step 4: Configure XMRig
    echo "Configuring XMRig..."
    cp ../config.json .

    # Step 5: Start mining
    echo "Starting XMR mining..."
    ./xmrig

    echo "XMR mining started successfully!"
}

# Usage example for installAndMineXMR function
installAndMineXMR