# Utilities
Usefull Scripts for working with the match mobile robots.
# Nvidia Graphics for Ubuntu:

```
sudo add-apt-repository ppa:graphics-drivers/ppa --yes
sudo apt update

sudo apt install nvidia-driver-470  # or nvidia-driver-495
```

# SSH

1. At SSH Client (do not type anything - just press enter):
 ```
ssh-keygen -t rsa
```
2. At SSH Server (this only needs to be done once for every server)
``` 
mkdir -p .ssh 
```

3. At SSH client
``` 
cat .ssh/id_rsa.pub | ssh mur 'cat >> .ssh/authorized_keys'
```
#More info for console outputs
Execute this in the console or add it to the .bashrc:
```
export ROSCONSOLE_FORMAT='[${severity}] [${time}] [${node}] [${logger}]: ${message}'
```

# Other
failed-to-fetch-binary-armhf-packages-error-
```sudo dpkg --remove-architecture armhf```



# IPs
scan for IPs in network: ```sudo nmap -sn 10.145.8.0/24```


| Device  | Static IP |
| ------------- | ------------- |
| fritz_box | 10.145.8.1 |
| Rocket M5  |    10.145.8.10 |
| MuR_AirLan  | 10.145.8.11  |
| MiRanda_AirLan  | 10.145.8.12  |
| stereo_AirLan  | 10.145.8.13  |
| master_SPS  | 10.145.8.20  |
| MiRanda_SPS  | 10.145.8.21  |
| MuR_SPS  | 10.145.8.22  |
| Spot_SPS  | 10.145.8.23  |
| mobile_master_SPS  | 10.145.8.24  |
| master_ethernet  | 10.145.8.30  |
| MiRanda_USB_ethernet  | 10.145.8.31  |
| mobile_master_ethernet  | 10.145.8.32  |
| MuR_ethernet  | 10.145.8.33  |
| mir200_robot_controller  | 10.145.8.34  |
| mir100_robot_controller  | 10.145.8.35  |
| spot_AirLan  | 10.145.8.36  |
| keyence_controller  | 10.145.8.37  |
| spot_ethernet  | 10.145.8.38  |
| keyence_pc_ethernet  | 10.145.8.39  |
| agilex_pc_ethernet  | 10.145.8.40  |
