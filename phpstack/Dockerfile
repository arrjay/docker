# build a Linux/Apache/PHP container.
# I don't feel like containerizing the damn databases.
FROM arrjay/cc:c7-latest
MAINTAINER RJ Bergeron <rbergero@gmail.com>
RUN yum -y install php php-cli httpd mod_ssl
RUN ln -sf /dev/stdout /var/log/httpd/access_log && ln -sf /dev/stderr /var/log/httpd/error_log && ln -sf /dev/stdout /var/log/httpd/ssl_access_log && ln -sf /dev/stderr /var/log/httpd/ssl_error_log
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80 443
