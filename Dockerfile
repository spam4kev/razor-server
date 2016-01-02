From centos/postgresql-94-centos7
VOLUME /var/lib/pgsql/data
ENV POSTGRESQL_USER razor
ENV POSTGRESQL_PASSWORD mypass
ENV POSTGRESQL_DATABASE razor_prd

From centos:latest
MAINTAINER "kev" spam4kev@gmail.com
COPY ./razor-server.sh /tmp/razor-server.sh
ADD http://links.puppetlabs.com/razor-microkernel-latest.tar /tmp
#Install deps
RUN yum update -y && \
    yum install -y \
	http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm \
        wget
RUN yum install -y razor-server && \
    chmod +x /tmp/razor-entrypoint.sh && \
    chmod +x /tmp/razor-server.sh
#the rest of the rasor server prep is performed via entrypoint script "razor-entrypoint.sh" in this git repo
