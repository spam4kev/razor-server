From centos:latest
MAINTAINER "kev" spam4kev@gmail.com

#Install stuff
RUN yum update -y && \
    yum install -y \
	http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm \
        wget
WORKDIR /var/lib/razor/repo-store
RUN yum install -y razor-server 
RUN sed -i 's/razor_prd/\/\/razor_db\/razor_prd/' /etc/razor/config.yaml && \
    $( [[ ! -f ./razor-microkernel-latest.tar ]] && wget http://links.puppetlabs.com/razor-microkernel-latest.tar ) && \
    tar -xf razor-microkernel-latest.tar && \
    razor-admin -e production migrate-database && \
    /etc/init.d/razor-server start

