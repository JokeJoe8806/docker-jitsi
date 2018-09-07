#!/bin/bash
sudo docker rm -f jitsi
sudo docker run -d --name jitsi -e HOST=192.168.10.129 -p 80:80 -p 443:443 -p  19302: 19302 -p 10000-10010:10000-10010/udp jokejoe/jitsi
