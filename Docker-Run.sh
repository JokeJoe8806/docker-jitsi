#!/bin/bash
sudo docker rm -f jitsi
sudo docker run -d --name jitsi -e HOST=192.168.10.131 -e PUBLIC_ADDRESS==192.168.10.131 -p 80:80 -p 443:443 -p 10000:10000/udp jokejoe/jitsi
