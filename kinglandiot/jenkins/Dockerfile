FROM ubuntu:12.04

MAINTAINER 冯宇(yu.feng@kinglandiot.com)

#初始化软件源
RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ precise main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-security main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-updates main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-proposed main restricted universe multiverse\n \
deb http://cn.archive.ubuntu.com/ubuntu/ precise-backports main restricted universe multiverse" > /etc/apt/sources.list
RUN echo 'Asia/Shanghai' > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update
RUN apt-get install wget language-pack-zh-hans -y

#更改语言环境
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
RUN echo 'LANG=zh_CN.UTF-8' > /etc/default/locale
RUN echo 'LC_ALL=zh_CN.UTF-8' >> /etc/default/locale

#这部分安装openjdk7用{
# Fake a fuse install
RUN export DEBIAN_FRONTEND=noninteractive; \
apt-get install libfuse2; \
cd /tmp ; apt-get download fuse; \
cd /tmp ; dpkg-deb -x fuse_* .; \
cd /tmp ; dpkg-deb -e fuse_*; \
cd /tmp ; rm fuse_*.deb; \
cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst; \
cd /tmp ; dpkg-deb -b . /fuse.deb; \
cd /tmp ; dpkg -i /fuse.deb;

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y openjdk-7-jdk;
#}

#初始化部分变量
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

#安装jenkins
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo 'deb http://pkg.jenkins-ci.org/debian binary/' > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install jenkins -y
#安装mongodb
RUN apt-get install -y mongodb

#安装mysql
RUN export DEBIAN_FRONTEND=noninteractive; \
echo 'mysql-server mysql-server/root_password password root' | debconf-set-selections; \
echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections; \
apt-get -y install mysql-server;

#安装openssh-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server
RUN mkdir /var/run/sshd

#安装git
RUN apt-get install -y git

#这四个目录不提交
VOLUME ["/var/lib/mysql", "/var/lib/mongodb", "/var/lib/jenkins", "/var/log"]

#暴露ssh端口和jenkins的ajp端口
EXPOSE 8009 8080 22

#定义启动脚本
ADD start.sh /start.sh

#修改服务配置
ADD my.cnf /etc/mysql/my.cnf
ADD jenkins /etc/default/jenkins
RUN echo 'root:jenkins' | chpasswd

#安装完毕后清理临时文件
RUN apt-get autoremove -y ; apt-get clean

#容器自启动脚本
CMD ["/start.sh"]
