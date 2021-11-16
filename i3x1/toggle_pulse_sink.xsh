#!/usr/bin/env xonsh

import itertools

SINKS = [
    "bluez_sink.00_1B_66_B1_12_6C.a2dp_sink",
    "alsa_output.usb-Plantronics_Plantronics_BT600_e006012246d2dc419f7423a54ca2cb6f-00.analog-stereo",
    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink",
]

sinks = itertools.cycle(SINKS)

cur_sink = $(pactl get-default-sink).strip()

while True:
    if cur_sink == next(sinks):
        break

pactl set-default-sink @(next(sinks))



