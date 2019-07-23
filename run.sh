#!/bin/bash
set -x
echo "start"
echo "jitsi-videobridge jitsi-videobridge/jvb-hostname string $HOST" | debconf-set-selections
echo "jitsi-meet jitsi-meet/cert-choice select Self-signed certificate will be generated" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get -y install jitsi-meet
chmod +x /JitsiMeet.sh
/JitsiMeet.sh

inet=$(ifconfig eth0|grep inet|grep -v 127.0.0.1|grep -v inet6 | awk '{print $2}' | tr -d "addr:")
echo "org.jitsi.videobridge.SINGLE_PORT_HARVESTER_PORT=10000" >>/etc/jitsi/videobridge/sip-communicator.properties && \
echo "org.ice4j.ice.harvest.NAT_HARVESTER_LOCAL_ADDRESS=$inet" >>/etc/jitsi/videobridge/sip-communicator.properties && \
echo "org.ice4j.ice.harvest.NAT_HARVESTER_PUBLIC_ADDRESS=$PUBLIC_ADDRESS" >>/etc/jitsi/videobridge/sip-communicator.properties

service nginx restart
service prosody restart
service jicofo restart
service jitsi-videobridge restart
tail -f /dev/null
