# CentOS 7/Python 3.x web-application base image

FROM centos:7
MAINTAINER https://github.com/bcambl

RUN yum update -y \
    && yum install -y gcc make openssl-devel sqlite-devel zlib-devel git \
    && curl -O https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz \
    && tar -zxvf Python-3.5.2.tgz \
    && cd Python-3.5.2 \
    && ./configure --prefix=/usr/local --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib" \
    && make \
    && make altinstall \
    && cd / \
    && rm -rf Python-3.5.2* \
    && yum install -y epel-release \
    && yum install -y npm \
    && npm install -g inherits \
    && npm install -g bower \
    && bower cache clean --allow-root \
    && yum clean all \
    && rpm --rebuilddb

RUN useradd -c "unprivileged application user" -m -r webapp

CMD ["/bin/bash"]
