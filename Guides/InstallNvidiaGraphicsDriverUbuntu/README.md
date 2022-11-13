# How to install Nvidia graphics driver for Ubuntu:

```
sudo add-apt-repository ppa:graphics-drivers/ppa --yes
sudo apt update

sudo apt install nvidia-driver-510  # or nvidia-driver-495
sudo apt install --ugrade linux-modules-nvidia-510-generic
```
