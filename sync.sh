#!/bin/sh
rsync --update --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@mur:~/catkin_tools_ws/
rsync --update --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@miranda:~/catkin_tools_ws/
while inotifywait -r -e modify,create,delete,move  ~/catkin_tools_ws/src; do
	rsync --update --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@mur:~/catkin_tools_ws/
rsync --update --delete -avzhe ssh ~/catkin_tools_ws/src rosmatch@miranda:~/catkin_tools_ws/
done
