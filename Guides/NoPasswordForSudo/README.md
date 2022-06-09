# Remove the need to type in the sudo password 

1. Edit visudo
 ```
sudo visudo
```
2. Add this line at the end:
``` 
rosmatch ALL=(ALL) NOPASSWD: ALL
```
3. Save the file