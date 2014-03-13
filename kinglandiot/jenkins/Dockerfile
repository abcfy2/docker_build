FROM ubuntu:12.04
MAINTAINER 冯宇(yu.feng@kinglandiot.com)

ADD sources.list /etc/sources.list
RUN apt-get update
RUN apt-get install wget language-pack-zh-hans -y
RUN echo 'LANG=zh_CN.UTF-8' > /etc/default/locale
RUN echo 'LC_ALL=zh_CN.UTF-8' >> /etc/default/locale



EXPOSE 8009 22
CMD ["/start.sh"]
