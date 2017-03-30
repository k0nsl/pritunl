FROM debian:jessie

MAINTAINER k0nsl <i.am@k0nsl.org>

RUN locale-gen en_US en_US.UTF-8 &&\
    #dpkg-reconfigure locales &&\
    #ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    apt-get update -q &&\
    apt-get upgrade -y -q &&\
    apt-get dist-upgrade -y -q &&\
    apt-get install -y software-properties-common python-software-properties &&\
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main" >> /etc/apt/sources.list.d/mongodb-org-3.2.list &&\
    echo "deb http://repo.pritunl.com/stable/apt jessie main" >> /etc/apt/sources.list.d/pritunl.list &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 42F3E95A2C4F08279C4960ADD68FA50FEA312927 &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A &&\
    apt-get update -q &&\
    apt-get -y install pritunl mongodb-org &&\
    systemctl start mongod pritunl &&\
    systemctl enable mongod pritunl &&\
    apt-get clean all &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\
    rm -rf /tmp/*

ADD start-pritunl /bin/start-pritunl

EXPOSE 9700
EXPOSE 1194
EXPOSE 11194

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]
