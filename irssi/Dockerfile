# build a Linux/Apache/PHP container.
# I don't feel like containerizing the damn databases.
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
RUN yum -y install irssi
ENTRYPOINT ["/usr/bin/irssi"]
