#!/bin/sh
# update & upgrade #
sudo apt-get update -y
sudo apt-get upgrade -y

# Essentials
cp .startup_shell_text.sh ~/
cp .font.txt ~/
sudo chmod +x ~/.startup_shell_text.sh
sudo apt install net-tools -y
#sudo add-apt-repository ppa:gnome-terminator
sudo apt-get install terminator -y
sudo snap install --classic code -y
sudo apt-get install hardinfo -y
sudo apt install can-utils -y
pip install python-can

# Configure ROS One apt repository
sudo apt install curl
sudo curl -sSL https://ros.packages.techfak.net/gpg.key -o /etc/apt/keyrings/ros-one-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros-one-keyring.gpg] https://ros.packages.techfak.net $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros1.list
echo "# deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros-one-keyring.gpg] https://ros.packages.techfak.net $(lsb_release -cs) main-dbg" | sudo tee -a /etc/apt/sources.list.d/ros1.list

# Install and setup rosdep
# Do not install python3-rosdep2, which is an outdated version of rosdep shipped via the Ubuntu repositories (instead of ROS)!
sudo apt update
sudo apt install python3-rosdep
sudo rosdep init

# Define custom rosdep package mapping
echo "yaml https://ros.packages.techfak.net/ros-one.yaml one" | sudo tee /etc/ros/rosdep/sources.list.d/1-ros-one.list
rosdep update

# Install packages, e.g. ROS desktop
sudo apt install ros-one-desktop

# install dependencies manually (this should usually be done through rosdep) 
sudo apt install ros-one-costmap-2d -y
sudo apt install ros-one-serial -y
sudo apt install ros-one-nav-core -y
sudo apt install ros-one-moveit-core -y
sudo apt install ros-one-ur-client-library -y
sudo apt install ros-one-moveit-ros-planning-interface -y
sudo apt install ros-one-mbf-msgs -y
sudo apt install ros-one-mir-actions -y
sudo apt install ros-one-navfn -y
sudo apt install ros-one-industrial-robot-status-interface -y
sudo apt install ros-one-move-base-msgs -y
sudo apt install ros-one-scaled-joint-trajectory-controller -y
sudo apt install ros-one-rospy-message-converter -y
sudo apt install ros-one-speed-scaling-interface -y
sudo apt install ros-one-speed-scaling-state-controller -y
sudo apt install ros-one-pass-through-controllers -y
sudo apt install libserial-dev -y
sudo apt install ros-one-rqt-* -y
sudo apt install ros-one-moveit-planners* -y
sudo apt install ros-one-moveit-ros* -y
apt install ros-one-ros-control* -y
sudo apt install ros-one-moveit-commander -y
sudo apt install ros-one-pcl-ros -y
sudo apt install ros-one-tf2-sensor-msgs -y
