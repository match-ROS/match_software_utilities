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
cat .ssh/id_rsa.pub | ssh SSH_SERVER_NAME 'cat >> .ssh/authorized_keys'
```
