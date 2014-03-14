FROM ubuntu:12.04

MAINTAINER 冯宇(yu.feng@kinglandiot.com)

#初始化软件源
RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ precise main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-security main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-updates main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-proposed main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" > /etc/apt/sources.list
RUN echo 'Asia/Shanghai' > /etc/timezone
RUN apt-get update
RUN apt-get install language-pack-zh-hans -y

#更改语言环境
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
RUN echo 'LANG=zh_CN.UTF-8' > /etc/default/locale
RUN echo 'LC_ALL=zh_CN.UTF-8' >> /etc/default/locale

#安装mysql
RUN export DEBIAN_FRONTEND=noninteractive; \
echo 'mysql-server mysql-server/root_password password root' | debconf-set-selections; \
echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections; \
apt-get -y install mysql-server;

#暴露mysql端口
EXPOSE 3306

#定义启动脚本
ADD start.sh /start.sh

#修改服务配置
ADD my.cnf /etc/mysql/my.cnf
RUN /usr/bin/mysqld_safe & \
sleep 2; \
mysql -u root -proot -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION ; FLUSH PRIVILEGES"

#安装完毕后清理临时文件
RUN apt-get autoremove -y ; apt-get clean

#容器自启动脚本
CMD ["/start.sh"]
