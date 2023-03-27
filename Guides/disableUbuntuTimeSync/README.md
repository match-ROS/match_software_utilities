# Disable automatic internet time sync on Ubuntu

1. Install NTP:
 ```
sudo apt install systemd-timesyncd
```
2. Turn NTP off
``` 
timedatectl set-ntp false 
```


