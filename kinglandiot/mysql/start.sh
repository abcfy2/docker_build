#!/bin/bash

chmod 1777 /tmp

#启动mysql
chown -R mysql /var/lib/mysql
if [ ! -f /var/lib/mysql/ibdata1 ]; then
    mysql_install_db
    /usr/bin/mysqld_safe &
    sleep 10s
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
    killall mysqld
    sleep 10s
fi
/usr/bin/mysqld_safe
