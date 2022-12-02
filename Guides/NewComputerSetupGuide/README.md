# Guide for the setup procedure for a new computer or robot

This guide contains all information about how to setup a new computer into the mobile robotics network. This guide also works when including new robots into the network.

1. Get all entries from an already setup `hosts`-file
    1. Open a new terminal and SSH onto another computer that was allready setup.
    2. Navigate to the `hosts`-file and open it using: `sudo nano /etc/hosts`
    3. Copy all IP-entries (except the first two)

2. Set a static IP adress for the current computer using this guide: [Link](https://github.com/matchRos/Utilities/tree/master/Guides/AssignStaticIPToComputer)

3. Add the current computer with its static IP to all other `hosts`-files on the different computers in the network. 
**ATTENTION:** The name in the `hosts`-file next to the IP-adress has to be the name of the new computer.

4. Change the ROS_MASTER_URI to the IP or name of the Leitstand.
