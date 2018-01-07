import os

pianobar_path = os.envrion.get("PIANOBAR_CONFIG_PATH")
pandora_email = os.environ.get("PANDORA_EMAIL")
pandora_email = "user = " + pandora_email
pandora_psw = os.environ.get("PANDORA_PSW")
pandora_psw = "password = " + pandora_psw
pandora_audio_quality = os.environ.get("PANDORA_AUDIO_QUALITY") or "low"
pandora_audio_quality = "audio_quality = " + pandora_audio_quality
pandora_station = os.environ.get("PANDORA_AUTO_STATION")
if pandora_station is not None:
    pandora_station = "autostart_station = " + pandora_station

pianobar_file = os.path.join(pianobar_path, 'config')
event = "event_command = " + os.path.join(pianobar_path, "eventcmd")
#pianobar_file = os.path.join(os.getcwd(), 'config')

with open(pianobar_file, 'a') as fl:
    if pandora_station is None:
        fl.write(pandora_email + '\n' + pandora_psw + '\n' + \
        pandora_audio_quality + "\n" + event)
    else:
        fl.write(pandora_email + '\n' + pandora_psw + '\n' + \
        pandora_audio_quality + "\n" + pandora_station + "\n" + event)
