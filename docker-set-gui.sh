#!/bin/sh
rm ~/.Xauthority
touch ~/.Xauthority
xauth -f ~/.Xauthority add ${HOST}:0 . $(xxd -l 16 -p /dev/urandom)
sudo rm -rf /tmp/.docker.xauth
touch /tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
