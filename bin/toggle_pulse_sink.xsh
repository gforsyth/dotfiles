#!/usr/bin/env xonsh
import time

import itertools


SINK_ICON = {
    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink": "🔈",
    "bluez_output.58_FC_C6_4B_8C_06.a2dp-sink": "👂💊",
}


MY_SINKS = [
    "bluez_sink.00_1B_66_B1_12_6C.a2dp_sink",
    "bluez_sink.88_C9_E8_25_61_AA.a2dp_sink",
    "alsa_output.usb-Plantronics_Plantronics_BT600_e006012246d2dc419f7423a54ca2cb6f-00.analog-stereo",
    "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink",
    "bluez_sink.58_FC_C6_4B_8C_06.a2dp_sink",
    "bluez_sink.58_FC_C6_4B_8C_06.handsfree_head_unit",
]

if "XPS" in $HOST:
    MY_SINKS = [
        "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink",
        "bluez_output.58_FC_C6_4B_8C_06.a2dp-sink",
    ]

AVAILABLE_SINKS = $(pactl list sinks short | cut -f2).strip().split()

SINKS = set(MY_SINKS).intersection(AVAILABLE_SINKS)

sinks = itertools.cycle(SINKS)

cur_sink = $(pactl get-default-sink).strip()

TIC = time.time()

while True and time.time() - TIC < 2:
    if cur_sink == next(sinks):
        break

next_sink = next(sinks)

pactl set-default-sink @(next_sink)


