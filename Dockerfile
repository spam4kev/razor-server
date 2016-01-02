From centos:latest
MAINTAINER "kev" spam4kev@gmail.com

#Install stuff
RUN yum update -y && \
    yum install -y \
	http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y razor-server 
CMD \
    echo Setting up iptables...
