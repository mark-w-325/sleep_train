import os

pandora_email = os.environ.get("PANDORA_EMAIL")
pandora_email = "user = " + pandora_email
pandora_psw = os.environ.get("PANDORA_PSW")
pandora_psw = "password = " + pandora_psw
pandora_audio_quality = os.environ.get("PANDORA_AUDIO_QUALITY") or "low"
pandora_audio_quality = "audio_quality = " + pandora_audio_quality
pandora_station = os.environ.get("PANDORA_AUTO_STATION")
pandora_station = "autostart_station = " + pandora_station

pianobar_file = os.path.join('/root/.config/pianobar', 'config')
event = 'event_command = /root/.config/pianobar/eventcmd'
#pianobar_file = os.path.join(os.getcwd(), 'config')

with open(pianobar_file, 'a') as fl:
    fl.write(pandora_email + '\n' + pandora_psw + '\n' + pandora_audio_quality \
    + "\n" + pandora_station + "\n" + event)
