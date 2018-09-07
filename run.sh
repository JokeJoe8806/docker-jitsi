#!/bin/bash
set -x
echo "start"
echo "jitsi-videobridge jitsi-videobridge/jvb-hostname string $HOST" | debconf-set-selections
echo "jitsi-meet jitsi-meet/cert-choice select Self-signed certificate will be generated" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get -y install jitsi-meet
chmod +x /JitsiMeet.sh
/JitsiMeet.sh
service nginx start
service prosody start
service jicofo start
service jitsi-videobridge start
turnserver -n -a --listening-port=20000 -r risunton.com
tail -f /dev/null
