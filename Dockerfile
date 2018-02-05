FROM ubuntu:16.04

MAINTAINER Chris Cohoat <chris@cohoat.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git wget

RUN git clone https://github.com/ripple/rippled.git

WORKDIR /rippled

RUN git checkout develop

RUN apt-get -y install python-software-properties curl git scons ctags pkg-config protobuf-compiler libprotobuf-dev libssl-dev python-software-properties libboost-all-dev

RUN ./Builds/Ubuntu/install_boost.sh
ENV BOOST_ROOT=/rippled/boost_1_66_0/

RUN scons

RUN mkdir -p /etc/ripple
RUN mv build/rippled /etc/ripple
ADD ./ripple.conf /etc/ripple
ADD ./validators.txt /etc/ripple

WORKDIR /etc/ripple
RUN rm -rf /rippled

CMD ["/etc/ripple/rippled", "--conf", "/etc/ripple/ripple.conf"]