#!/bin/sh
echo "Sending to mur"
rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@mur:~/catkin_tools_ws/
echo "Sending to miranda"
rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@miranda:~/catkin_tools_ws/
#echo "Sending to master"
#rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@rosmaster:~/catkin_tools_ws/
while inotifywait -r -e modify,create,delete,move  ~/catkin_tools_ws/src; do
	echo "Sending to mur"
	rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@mur:~/catkin_tools_ws/
	echo "Sending to miranda"
	rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@miranda:~/catkin_tools_ws/
	#echo "Sending to master"
	#rsync --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@rosmaster:~/catkin_tools_ws/	
done
