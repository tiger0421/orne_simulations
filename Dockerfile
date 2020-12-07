FROM naokitakahashi12/ignition:citadel-devel-bionic

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's#http://tw.archive.ubuntu.com/#http://archive.ubuntu.com/#' /etc/apt/sources.list && \
    apt update && \
    apt install -y \
        dpkg \
        software-properties-common \
        git \
        curl \
        wget \
        lsb-release \
        python3-argcomplete \
        gnupg2 \
        dirmngr \
        g++ \
        fluid \
        build-essential \
        vim \
        tmux \
        gcc-8 \
        g++-8 \
    && \
    echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    wget http://packages.ros.org/ros.key -O - | apt-key add - \
    && \
    apt update && \
    apt install -y --no-install-recommends \
        ros-melodic-desktop-full \
        python-catkin-tools \
        python-rosdep \
        python-rosinstall-generator \
        python-wstool \
        python-rosinstall \
    && \
    echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list && \
    wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - && \
    apt update && \
    apt install -y \
        ros-melodic-ros-ign \
        libignition-common3-dev \
        libignition-transport8-dev \
        libignition-msgs5-dev \
    && \
    apt upgrade -y && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV IGNITION_VERSION=citadel
WORKDIR /root/ign_ros_ws/src/
RUN git clone https://github.com/osrf/ros_ign.git -b melodic
WORKDIR /root/ign_ros_ws
RUN apt update && \
    rosdep init && \
    rosdep update && \
    rosdep install --from-paths src -i -y --rosdistro melodic \
    --skip-keys=ignition-gazebo2 \
    --skip-keys=ignition-gazebo3 \
    --skip-keys=ignition-msgs4 \
    --skip-keys=ignition-msgs5 \
    --skip-keys=ignition-rendering2 \
    --skip-keys=ignition-rendering3 \
    --skip-keys=ignition-sensors2 \
    --skip-keys=ignition-sensors3 \
    --skip-keys=ignition-transport7 \
    --skip-keys=ignition-transport8 && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; . /ign_ws/install/setup.bash; catkin_make install"

RUN echo . /ign_ws/install/setup.bash >> /root/.bashrc && \
    echo . /opt/ros/melodic/setup.bash >> /root/.bashrc && \
    echo . /root/ign_ros_ws/devel/setup.bash >> /root/.bashrc

RUN curl https://raw.githubusercontent.com/tiger0421/orne_simulations/main/robot.sdf > /var/tmp/robot.sdf

WORKDIR /root
CMD /bin/bash
