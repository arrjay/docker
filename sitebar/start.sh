#!/bin/bash

# extract env settings into /var/www/html/sitebar/adm/config.inc.php
cat <<END_CONFIG>/var/www/html/sitebar/adm/config.inc.php
<?php
\$SITEBAR = array
(
  'db' => array
  (
    'host'     => '$MYSQL_HOST',
    'username' => 'sitebar',
    'password' => $SITEBAR_PASS,
    'name'     => 'sitebar',
  ),
  'baseurl' => null,
  'login_as' => null,
);
?>
END_CONFIG

# set the timezone
echo "date.timezone = ${TIMEZONE}" >> /etc/php.ini

# drop the env vars
unset SITEBAR_PASS
unset TIMEZONE

# start httpd
/usr/sbin/httpd -D FOREGROUND
