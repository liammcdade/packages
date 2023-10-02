#/bin/bash
sudo apt update 
sudo apt upgrade 
sudo apt install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev 
sudo git clone https://github.com/xmrig/xmrig.git
cd xmrig 
sudo mkdir build
cd build 
sudo cmake ..
 sudo make
./xmrig -u 469BLJrSuanFAgyw1QnoMjV5CaZbARRNcHznox7v4seRSTK7GvKf1y2bZTRSzrQjrK8ikbe7woWYaLM39bNxJiWkD553YTG -p linux
