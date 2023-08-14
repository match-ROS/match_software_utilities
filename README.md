# Utilities
Usefull Scripts for working with the match mobile robots.


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
| master  | 10.145.8.30  |
| MiRanda_USB  | 10.145.8.31  |
| mobile_master  | 10.145.8.32  |
| MuR_ethernet  | 10.145.8.33  |
| mir200_robot_controller  | 10.145.8.34  |
| mir100_robot_controller  | 10.145.8.35  |
| spot_AirLan  | 10.145.8.36  |
| keyence_controller  | 10.145.8.37  |
| spot | 10.145.8.38  |
| keyence_pc  | 10.145.8.39  |
| agilex_pc  | 10.145.8.40  |
| (agilex2_pc  | 10.145.8.41)  |
| rosmaster2  | 10.145.8.42  |
| UR16e  | 10.145.8.43 |
| mir600a_robot_controller | 10.145.8.44 |
| mir600a_AirLan_receiver | 10.145.8.45 |
| mir600b_AirLan_transmitter | 10.145.8.46 |
| mir600b_AirLan_receiver | 10.145.8.47 |
| mir600a_robot_controller | 10.145.8.xx |
| mir600b_robot_controller | 10.145.8.49 |
| mir600c_robot_controller | 10.145.8.48 |
| mur620c | 10.145.8.41 |
| mur620b | 10.145.8.54 |
| roscore | 10.145.8.50 |

# Mir PC
## SSH Access
i.e. for timesync of MiR with chrony
1. Boot with Linux Live-USB (connect Display and Keyboard to PC)
2. Mount filesystem for later use with chroot:
```
sudo mkdir -p /media/mir
sudo mount /media/mir/ /dev/sda3
sudo mount --bind /dev/ /media/mir/@/dev
sudo mount --bind /run/ /media/mir/@/run
```
3. Chroot into system
```
sudo chroot /media/mir/@/
```

4. Create User for later access via ssh:
```
adduser rosmatch
usermod -aG sudo rosmatch
```

## Install Chrony via SSH or created login
```
sudo apt install chrony

# if not installable (to fix broken dependencies):
sudo apt -f install
sudo apt install chrony
```

### Configure Chrony:
add server 10.145.8.50 to config:
```
echo "server 10.145.8.50 #roscore" | sudo tee -a /etc/crony/crony.conf

sudo systemctl restart chrony

# check if new server is on top:
chronyd sources
```

# Testing with Github
To test your ros package with github you have to use *rostest*. For testing in a workflow with github, the [Industrial CI](https://github.com/ros-industrial/industrial_ci.git) package can be used.

## Test package
Create test scripts with *rostest* and different *TestCase*. An example can be found [here](https://github.com/pumablattlaus/test_packages_tutorial)

## Workflow in Github
With the *Industrial CI* package it is possible to check whether the package can be build in the specified ROS-Version and if the specified test cases are successful.
For using the package, a yml-file is created in .github/workflows/ .
Depending on this file, the workflow can be started manually, at push or merge of a branch.
