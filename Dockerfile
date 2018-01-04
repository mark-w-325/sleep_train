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
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Python
RUN apt-get install -y \
  python \
  python-dev \
  python-pip \
  --no-install-recommends

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY pypianobar/pypianobar.py pypianobar.py

RUN mkdir -p /root/.config/pianobar
RUN mkfifo /root/.config/ctl
COPY eventcmd /root/.config/eventcmd
RUN chmod +x /root/.config/pianobar/eventcmd

RUN fingerprint=$(openssl s_client -connect tuner.pandora.com:443 < /dev/null 2> /dev/null | openssl x509 -noout -fingerprint | tr -d ':' | cut -d'=' -f2) && echo tls_fingerprint = $fingerprint >> /root/.config/pianobar/config

ENTRYPOINT []
CMD ["/bin/sh"]
