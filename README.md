# Utilities
Usefull Scripts for working with the match mobile robots.
# Nvidia Graphics for Ubuntu:

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
| agilex_AirLan  | 10.145.8.14  |
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
| agilex2_pc_ethernet  | 10.145.8.41  |


# IP routing
## route throught Miranda-PC with iptables
### Example
panda: 192.168.13.90, client: 10.145.8.250:
```
sudo iptables -t nat -A PREROUTING -i enx0050b6ffe45f -p tcp --dport 443 -j DNAT --to-destination 192.168.13.90:443
sudo iptables -t nat -A PREROUTING -i enx0050b6ffe45f -p tcp --dport 80 -j DNAT --to-destination 192.168.13.90:80
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
```

All input on interface enx0050b6ffe45f at dport gets redirected to destination.
MASQUERADE: ip address of miranda is used (clients ip address is exchanged)

### info
To get the interface used for ip-address 10.145.8.250: ``` ip route get 10.145.8.250 ```.
Forwarding has to be enabled (default).

das Package iptables-persistent lädt die gespeicherten iptables beim Neustart. Hierfür die momentanen Regeln über folgenden Befehl speichern:
``` sudo sh -c "iptables-save > /etc/iptables/rules.v4" ```
