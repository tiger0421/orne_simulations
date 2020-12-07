# orne_simulations

# Usage
## How to build an docker-image 
```
($ cd ~/)
$ git clone https://github.com/tiger0421/orne_simulations.git
$ cd ~/orne_simulations
$ docker-compose build
```

## How to run gazebo
Use some terminals to run ign_gazebo.
```
cd ~/orne_simulations

// For using gui on docker
$ touch ~/.Xauthority
$ . docker-set-gui.sh
// end

(Terminal A)
$ docker-compose up

(Terminal B)
$ docker exec -it ros-ign bash
# ign gazebo -r /var/tmp/robot.sdf

(Terminal C)
$ docker exec -it ros-ign bash
# rosrun ros_ign_bridge parameter_bridge /lidar/points@sensor_msgs/PointCloud2@ignition.msgs.PointCloudPacked

(Terminal D)
$ docker exec -it ros-ign bash
# rviz
(frame-id is "vehicle_blue/chassis/gpu_lidar")
```
Move a robot with arrow keys, be sure the focus is on the gazebo.

# Movie
https://youtu.be/RZI7npUTQ7U
