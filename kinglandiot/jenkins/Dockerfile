FROM ubuntu:12.04

MAINTAINER 冯宇(yu.feng@kinglandiot.com)

#初始化软件源
RUN echo 'deb http://mirror.bjtu.edu.cn/ubuntu/ precise main multiverse restricted universe' > /etc/apt/sources.list
RUN echo 'deb http://mirror.bjtu.edu.cn/ubuntu/ precise-backports main multiverse restricted universe' >> /etc/apt/sources.list
RUN echo 'deb http://mirror.bjtu.edu.cn/ubuntu/ precise-proposed main multiverse restricted universe' >> /etc/apt/sources.list
RUN echo 'deb http://mirror.bjtu.edu.cn/ubuntu/ precise-security main multiverse restricted universe' >> /etc/apt/sources.list
RUN echo 'deb http://mirror.bjtu.edu.cn/ubuntu/ precise-updates main multiverse restricted universe' >> /etc/apt/sources.list
RUN echo 'Asia/Chongqing' > /etc/timezone
RUN apt-get update
RUN apt-get install wget language-pack-zh-hans -y

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
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
RUN echo 'LANG=zh_CN.UTF-8' > /etc/default/locale
RUN echo 'LC_ALL=zh_CN.UTF-8' >> /etc/default/locale

#安装jenkins
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo 'deb http://pkg.jenkins-ci.org/debian binary/' > /etc/apt/sources.list.d/jenkins.list
RUN apt-get update
RUN apt-get install jenkins -y

#安装mongodb
RUN apt-get install -y mongodb

#安装mysql
RUN echo 'mysql-server-5.5 mysql-server/root_password password root' | debconf-set-selections; \
echo 'mysql-server-5.5 mysql-server/root_password_again password root' | debconf-set-selections; \
apt-get -y install mysql-server;

#这三个目录不提交
VOLUME ["/var/lib/mysql", "/var/lib/mongodb", "/var/lib/jenkins"]

#暴露ssh端口和jenkins的ajp端口
EXPOSE 8009 22

#定义启动脚本
ADD start.sh /start.sh

#修改服务配置
ADD my.cnf /etc/mysql/my.cnf
CMD ["/start.sh"]
