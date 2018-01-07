# Sleep Trainer for children using Raspberry Pi

## Overview

This utilizes the Docker image debian:stretch. This can be run on any version of Raspberry Pi with Docker installed.

This will control 2 LED lights (red and green). Red will signify that the child should not get out of bed or their room. Green will indicate that it is okay to get up and exit the room.
When the green light turns on, it will also trigger Pandora via pianobar to wake the child up to music.

## Interface

This uses Flask as the webhost and will allow parents to specify times for the lights to be on/off and pick a channel for Pandora to play.
