From centos:latest
MAINTAINER "kev" spam4kev@gmail.com

#Install stuff
RUN yum update -y && \
    yum install -y \
	http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm \
	razor-server 
RUN cp /var/lib/tftpboot/pxelinux.0 . && \
    cp /var/lib/tftpboot/menu.c32 . && \
    cp /var/lib/tftpboot/memdisk . && \
    cp /var/lib/tftpboot/mboot.c32 . && \
    cp /var/lib/tftpboot/chain.c32 .
WORKDIR /tftpboot/images/centos/x86_64/7
RUN wget -R index.html* -nH --cut-dirs=6 --level=1 --recursive --no-parent http://mirror.centos.org/centos/7/os/x86_64/images/pxeboot && \
    chmod 655 initrd.img && \
    printf "DEFAULT menu.c32\nPROMPT 0\nTIMEOUT 500\nONTIMEOUT centos\nMENU TITLE Main Menu\nLABEL centos\n	KERNEL images/centos/x86_64/7/vmlinuz\n	APPEND initrd=images/centos/x86_64/7/initrd.img method=http://mirror.centos.org/centos/7/os/x86_64 devfs=nomount\n" >/tftpboot/pxelinux.cfg/default
CMD \
    echo Setting up iptables... && \
    iptables -t nat -A POSTROUTING -j MASQUERADE && \
    echo Waiting for pipework to give us the eth1 interface... && \
    /pipework --wait && \
    myIP=$(ip addr show dev eth1 | awk -F '[ /]+' '/global/ {print $3}') &&\
    mySUBNET=$(echo $myIP | cut -d '.' -f 1,2,3) &&\
    echo Starting DHCP+TFTP server...&& \
    dnsmasq --interface=eth1 \
            --dhcp-range=$mySUBNET.201,$mySUBNET.253,255.255.255.0,1h \
            --dhcp-boot=pxelinux.0,pxeserver,$myIP \
            --pxe-service=x86PC,"Install Linux",pxelinux \
            --enable-tftp --tftp-root=/tftpboot/ --no-daemon
