From centos:latest
MAINTAINER "kev" spam4kev@gmail.com

#Install stuff
RUN yum update -y && \
    yum install -y \
	http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y razor-server 
RUN sed -i 's/razor_prd/\/\/razor_db\/razor_prd/' /etc/razor/config.yaml && \
    razor-admin -e production migrate-database && \
    /etc/init.d/razor-server start

