wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.5.3.tar.xz
tar xvf linux-6.5.3.tar.xz
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
cd linux-6.5.3
cp -v /boot/config-$(uname -r) .config
make
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
sudo make modules_install
sudo make install
sudo update-initramfs -c -k linux-6.5.3
sudo update-grub
