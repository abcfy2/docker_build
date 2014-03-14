#!/bin/bash

chmod 1777 /tmp

#启动mysql
chown -R mysql /var/lib/mysql
/usr/bin/mysqld_safe &

#启动mongodb
chown -R mongodb /var/lib/mongodb
/usr/bin/mongod -f /etc/mongodb.conf --fork

#启动jenkins
chown -R jenkins /var/lib/jenkins
service jenkins start

#启动ssh服务挂起
/usr/sbin/sshd -D
