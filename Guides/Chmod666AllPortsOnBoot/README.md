# Remove the need to give user permission to accsess a serial port (avoid chmod 666)

1. Edit or create myusb.rules
 ```
sudoedit /etc/udev/rules.d/50-myusb.rules
```
2. Add these lines at the end:
``` 
KERNEL=="ttyUSB[0-9]*",MODE="0666"
KERNEL=="ttyACM[0-9]*",MODE="0666"
```
3. Save the file
4. Replug the USB device
