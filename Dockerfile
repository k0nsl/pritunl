FROM ubuntu:17.04

MAINTAINER k0nsl <i.am@k0nsl.org>

RUN apt-get update -y &&\
    apt-get upgrade -y &&\
    apt-get dist-upgrade -y &&\
    apt-get install systemd software-properties-common python-software-properties -y &&\
    add-apt-repository ppa:pritunl/ppa &&\
    apt-get update -y &&\
    apt-get install pritunl -y &&\
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
