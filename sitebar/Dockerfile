# build a Linux/Apache/PHP container.
# I don't feel like containerizing the damn databases.
FROM arrjay/cc:phpstack
MAINTAINER RJ Bergeron <rbergero@gmail.com>
RUN yum -y install git php-mysql
# go get master
RUN cd /var/www/html && git clone https://github.com/brablc/sitebar.git
# wrapper to staple env vars into adm/config.inc.php
COPY sitebar.run /usr/sbin/sitebar.run
ENTRYPOINT ["/usr/sbin/sitebar.run"]
EXPOSE 80
EXPOSE 443
