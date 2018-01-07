# To Build
# docker build -t sleep_train:test .
# To Run (Need to add the sleep_train.env to the --env-list arg)
# docker run -it --rm --net host $(find /dev/snd/ -type c | sed 's/^/--device /') --privileged --name sleep_train sleep_train:test

FROM debian:stretch
LABEL maintainer "Mark Williams <maw325@gmail.com>"

# Install Main Items
RUN apt-get update && apt-get install -y \
    alsa-utils \
    libgl1-mesa-dri \
	  libgl1-mesa-glx \
	  libpangoxft-1.0-0 \
	  libpulse0 \
    pianobar \
    nano \
    openssl \
    ca-certificates \
    pulseaudio \
    python \
    python-dev \
    python-pip \
    python-setuptools \
    python-wheel \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ENV INSTALL_PATH /sleep_train
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY pianobar/pypianobar.py pypianobar.py

RUN mkdir -p /root/.config/pianobar
RUN mkfifo /root/.config/ctl
COPY pianobar/eventcmd /root/.config/pianobar/eventcmd
RUN chmod +x /root/.config/pianobar/eventcmd

RUN fingerprint=$(openssl s_client -connect tuner.pandora.com:443 < /dev/null 2> /dev/null | openssl x509 -noout -fingerprint | tr -d ':' | cut -d'=' -f2) && echo tls_fingerprint = $fingerprint >> /root/.config/pianobar/config

ENTRYPOINT []
CMD ["/bin/sh"]
