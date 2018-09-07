FROM tiredofit/debian:stretch
LABEL maintainer="Joke Joe"
ENV HOST 127.0.0.1

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
	# echo "deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list && \
	# echo "deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list && \
	# echo "deb http://mirrors.aliyun.com/debian-security stretch/updates main" >>/etc/apt/sources.list && \
	# echo "deb-src http://mirrors.aliyun.com/debian-security stretch/updates main" >>/etc/apt/sources.list && \
	# echo "deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
	# echo "deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
	# echo "deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >>/etc/apt/sources.list && \
	# echo "deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib" >>/etc/apt/sources.list
RUN apt-get update && \
apt-get -y install apt-utils debconf-utils wget

RUN echo "deb https://download.jitsi.org stable/" >>/etc/apt/sources.list && \
curl -sSL  https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add - && \
echo "nameserver 8.8.8.8" >>/etc/resolv.conf && \
apt-get update && \
apt-get -y install nginx && \
apt-get -y -d install jitsi-meet


EXPOSE 80 443 4443 5222 5280 5347
EXPOSE 10000-20000/udp

COPY JitsiMeet.sh /JitsiMeet.sh
COPY jitsi-meet/ /jitsi-meet/
COPY run.sh /run.sh
CMD ["/bin/bash","/run.sh"]
