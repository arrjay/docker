# bitlbee with faceboot-mqtt support
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
COPY arrjay-bitlbee-facebook-mqtt.pub /etc/pki/rpm-gpg/arrjay-bitlbee-facebook-mqtt.pub
COPY bitlbee-facebook-mqtt.repo /etc/yum.repos.d/bitlbee-facebook-mqtt.repo
COPY arrjay-bitlbee.pub /etc/pki/rpm-gpg/arrjay-bitlbee.pub
COPY arrjay-bitlbee.repo /etc/yum.repos.d/bitlbee-faceboot-mqtt.repo
RUN adduser -u 1500 bitlbee
RUN yum -y install epel-release && yum -y install bitlbee-facebook
COPY bitlbee.conf /etc/bitlbee/bitlbee.conf
RUN mkdir /bitlbee && chown bitlbee:bitlbee /bitlbee
COPY motd.txt /motd.txt
COPY start.sh /start.sh
RUN echo "image assembled $(date +%Y-%m-%d) ($(date +%s))" >> /motd.txt && chmod a+r /motd.txt
VOLUME ["/bitlbee"]
ENTRYPOINT ["/start.sh"]
EXPOSE 6667
