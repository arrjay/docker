# build a Linux/Apache/PHP container.
# I don't feel like containerizing the damn databases.
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
COPY arrjay-bitlbee-facebook-mqtt.pub /etc/pki/rpm-gpg/arrjay-bitlbee-facebook-mqtt.pub
COPY bitlbee-facebook-mqtt.repo /etc/yum.repos.d/bitlbee-facebook-mqtt.repo
RUN yum -y install epel-release && yum -y install bitlbee bitlbee-facebook
COPY bitlbee.conf /etc/bitlbee/bitlbee.conf
ENTRYPOINT ["/usr/sbin/bitlbee", "-n"]
EXPOSE 6667