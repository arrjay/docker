# znc with modules
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
COPY znc-modules.gpg /etc/pki/rpm-gpg/arrjay-znc-modules.pub
COPY znc-modules.repo /etc/yum.repos.d/znc-modules.repo
RUN adduser -u 1501 znc
RUN yum -y install epel-release && yum -y install znc znc-colloquypush znc-push znc-chanfilter znc-autojoin
RUN mkdir -p /znc && chown -R znc:znc /znc
COPY start.sh /start.sh
VOLUME ["/znc"]
ENTRYPOINT ["/start.sh"]
