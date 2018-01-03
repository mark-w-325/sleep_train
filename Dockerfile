FROM resin/rpi-raspbian:stretch
MAINTAINER Mark Williams <maw325@gmail.com>
ENTRYPOINT []

RUN apt-get -q update && \
    apt-get -qy install apt-utils \
    python \
    python-dev \
    python-pip \
    python-virtualenv \
    pulseaudio \
    pianobar \
    screen \
    nano \
    alsa-utils \
    pulseaudio-utils gstreamer1.0 gstreamer0.10-pulseaudio libsdl1.2debian \
    --no-install-recommends && \
    apt-get upgrade pianobar pulseaudio && \
    apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY pypianobar/pypianobar.py pypianobar.py

#RUN amixer cset numid=3 1

WORKDIR /root

RUN mkdir -p .config/pianobar

WORKDIR /root/.config/pianobar

RUN fingerprint=$(openssl s_client -connect tuner.pandora.com:443 < /dev/null 2> /dev/null | openssl x509 -noout -fingerprint | tr -d ':' | cut -d'=' -f2) && echo tls_fingerprint = $fingerprint >> config

WORKDIR ../../..

CMD ["/bin/sh"]
