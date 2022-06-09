# Guide for the procedure to assign a static IP adress to a device

1. SSH onto the Raspberry Pi (`10.145.8.249`) that hosts the DHCP server in our network.
    - username: ubuntu
    - password: admin password just letters
2. Add a new entry into the `dhcpd.conf`-file on the Raspberry Pi for the device that should receive a static IP adress using: `sudo nano /etc/dhcp/dhcpd.conf`
    - Copy + paste an existing entry
    - Rename, Change MAC-adress (see network adapter of device for this) and IP (use last IP-adress and add one to the last number)
3. Execute `sudo reboot`
