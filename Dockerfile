FROM ubuntu:trusty

MAINTAINER Goacid <goacid@kurty.net>

ENV DEBIAN_FRONTEND noninteractive

# Prepare erlang environment
ENV ERL_VERSION R15B03
ENV SRV_NAME otp_src

# install curl and erlang compilation deps
RUN apt-get update && \
    apt-get install -qy \
    curl \
    libwxbase2.8-dev \
    libssl-dev \
    libncurses5-dev \
    wx-common \
    libssl0.9.8 \ 
    gcc \
    make \
    build-essential

# Retrieve Erlang source and put it into /tmp
RUN cd /tmp && \
    curl -s http://www.erlang.org/download/${SRV_NAME}_${ERL_VERSION}.tar.gz | tar xz 
    
# Compilation time
RUN cd /tmp/${SRV_NAME}_${ERL_VERSION} &&\
    set -e &&\
    export HOME=/root &&\
     ./configure && make && make install

#Clean apt datas
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

#ENTRYPOINT [""]
