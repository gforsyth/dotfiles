#!/usr/bin/env xonsh
import time

import itertools


MY_SINKS = [
    "bluez_sink.00_1B_66_B1_12_6C.a2dp_sink",
    "alsa_output.usb-Plantronics_Plantronics_BT600_e006012246d2dc419f7423a54ca2cb6f-00.analog-stereo",
    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink",
]

AVAILABLE_SINKS = $(pactl list sinks short | cut -f2).strip().split()

SINKS = set(MY_SINKS).intersection(AVAILABLE_SINKS)

sinks = itertools.cycle(SINKS)

cur_sink = $(pactl get-default-sink).strip()

TIC = time.time()

while True and time.time() - TIC < 2:
    if cur_sink == next(sinks):
        break

pactl set-default-sink @(next(sinks))



