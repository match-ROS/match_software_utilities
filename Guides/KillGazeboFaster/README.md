# How change the sig-term delay to close gazebo faster


`sudo gedit /opt/ros/noetic/lib/python3/dist-packages/roslaunch/nodeprocess.py`

Modify these lines:

`DEFAULT_TIMEOUT_SIGINT  = 1.0 #seconds - default: 15`

`DEFAULT_TIMEOUT_SIGTERM = 0.5 #seconds - default: 2`

