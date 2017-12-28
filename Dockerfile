FROM resin/rpi-raspbian:latest
MAINTAINER Mark Williams <maw325@gmail.com>
ENTRYPOINT []

RUN apt-get -q update && \
    apt-get -qy install \
        python python-pip \
        python-dev python-pip gcc make \
        pianobar \
        screen
