FROM resin/rpi-raspbian:latest
MAINTAINER Mark Williams <maw325@gmail.com>
ENTRYPOINT []

RUN apt-get -q update
RUN apt-get -qy install apt-utils
RUN apt-get -qy install libasound2-dev
RUN apt-get -qy install python
RUN apt-get -qy install python-pip
RUN apt-get -qy install python-dev python-pip gcc make
RUN apt-get -qy install pianobar
RUN apt-get -qy install screen
RUN apt-get -qy install nano
RUN apt-get upgrade
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

WORKDIR /root

RUN mkdir -p .config/pianobar

WORKDIR /root/.config/pianobar

COPY pandora-email.env pandora-email.env
COPY pandora-pw.env pandora-pw.env

RUN email=$(<pandora-email.env) && echo 'user = $email' >> config
RUN psw=$(<pandora-pw.env) && echo 'password = $psw' >> config
RUN echo 'audio_quality = high' >> config
RUN fingerprint=$(openssl s_client -connect tuner.pandora.com:443 < /dev/null 2> /dev/null | openssl x509 -noout -fingerprint | tr -d ':' | cut -d'=' -f2) && echo tls_fingerprint = $fingerprint >> config
RUN echo 'autostart_station = 3844261022002693378' >> config

WORKDIR ../../..

CMD ["pianobar"]
