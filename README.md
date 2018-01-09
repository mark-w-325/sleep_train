# Sleep Trainer for children using Raspberry Pi

## Overview

This utilizes the Docker image debian:stretch. This can be run on any version of Raspberry Pi with Docker installed.

This will control 2 LED lights (red and green). Red will signify that the child should not get out of bed or their room. Green will indicate that it is okay to get up and exit the room.
When the green light turns on, it will also trigger Pandora via pianobar to wake the child up to music.

## Interface

This uses Flask as the webhost and will allow parents to specify times for the lights to be on/off and pick a channel for Pandora to play.

## Requirements

  - Docker
  - This git repo

## Pre-requisites

You will need to rename the sleep_train_example.env will need to be renamed to sleep_train.env.
You will also need to change the variables in this file to your specifics.

## Docker Build

    docker build -t sleep_train .

## Docker Container

    docker run -it --rm --net host $(find /dev/snd/ -type c | sed 's/^/--device /') --privileged --env-file sleep_train.env --name sleep_train sleep_train
