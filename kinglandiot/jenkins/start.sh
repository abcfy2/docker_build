#!/bin/bash

chmod 1777 /tmp

#启动mysql
chown -R mysql /var/lib/mysql
if [ ! -f /var/lib/mysql/ibdata1 ]; then
    mysql_install_db
    /usr/bin/mysqld_safe &
    sleep 2
    echo "GRANT ALL ON *.* TO root@localhost IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
    killall mysqld
    sleep 10s
else
    /usr/bin/mysqld_safe &
fi

#启动mongodb
chown -R mongodb /var/lib/mongodb
/usr/bin/mongod -f /etc/mongodb.conf --fork

#启动jenkins
chown -R jenkins /var/lib/jenkins
service jenkins start

#启动ssh服务挂起
/usr/sbin/sshd -D
