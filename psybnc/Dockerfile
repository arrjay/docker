# build a Linux/Apache/PHP container.
# I don't feel like containerizing the damn databases.
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
RUN yum -y install make gcc
ADD http://www.psybnc.at/download/beta/psyBNC-2.3.2-7.tar.gz /usr/src/
RUN tar xf /usr/src/psyBNC-2.3.2-7.tar.gz -C /usr/src
RUN cd /usr/src/psybnc && make && rm salt.h && cp psybnc /usr/bin
RUN yum -y remove make gcc
COPY start.sh /
RUN mkdir /runtime
VOLUME ["/runtime"]
ENTRYPOINT ["./start.sh"]
