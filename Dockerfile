FROM centos:7

MAINTAINER Brian Lycett <brian@wheelybird.com>

ADD ./files/bin /usr/local/bin
ADD ./files/configuration /opt/configuration

RUN yum -y install epel-release iptables bash nss-pam-ldapd ca-certificates net-tools wget openssl && \
    wget http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm && yum -y install rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm && \
    yum -y install openvpn easy-rsa whatmask fail2ban google-authenticator ipcalc tcpdump strace && \
    yum -y upgrade && \
    mkdir /opt/easyrsa && cp -rp /usr/share/easy-rsa/3/{x509-types,easyrsa} /opt/easyrsa && \
    chmod a+x /usr/local/bin/*er-rhscl-7-rpms && \
    yum clean all && \
    rm -rf /var/cache/yum

EXPOSE 1194/udp 5555/tcp


# Copy openvpn PAM modules (with and without OTP)
ADD ./files/etc/pam.d/openvpn* /opt/
ADD ./files/easyrsa/* /opt/easyrsa/

# Use a volume for data persistence
VOLUME /etc/openvpn

CMD ["/usr/local/bin/entrypoint"]

