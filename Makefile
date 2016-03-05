version.txt : Makefile mkimage-mock.sh startup.sh yum.conf
	md5sum $^ > version.txt
