#!/bin/bash

#启动mysql
/usr/sbin/mysqld_safe &

#启动mongodb
/usr/bin/mongod -f /etc/mongodb.conf --fork

#启动jenkins
service jenkins start

#启动ssh服务挂起
/usr/sbin/sshd -D
