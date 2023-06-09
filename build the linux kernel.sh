wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.11.tar.xz
tar xvf linux-5.10.11.tar.xz
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
cd linux-6.0.7
make
cp -v /boot/config-$(uname -r) .config
make menuconfig
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
sudo make modules_install
sudo make install
sudo update-initramfs -c -k 6.0.7
sudo update-grub
