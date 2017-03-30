FROM ubuntu:17.04

MAINTAINER k0nsl <i.am@k0nsl.org>

RUN apt-get update -q &&\
    apt-get upgrade -y -q &&\
    apt-get dist-upgrade -y -q &&\
    apt-get install -y systemd software-properties-common python-software-properties &&\
    add-apt-repository ppa:pritunl/ppa &&\
    apt-get update -q &&\
    apt-get install -y pritunl &&\
    apt-get clean all &&\
    apt-get -y -q autoclean &&\
    apt-get -y -q autoremove &&\

ADD start-pritunl /bin/start-pritunl

EXPOSE 9700
EXPOSE 1194
EXPOSE 11194

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]
