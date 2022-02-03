# Utilities
Usefull Scripts for working with the match mobile robots.
# Nvidia Graphics for Ubuntu:

```
sudo add-apt-repository ppa:graphics-drivers/ppa --yes
sudo apt update

sudo apt install nvidia-driver-470  # or nvidia-driver-495
```

#SSH

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
