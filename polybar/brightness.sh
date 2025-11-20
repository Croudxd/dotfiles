#!/bin/bash
v=$(brightnessctl -c backlight | grep -oP '\(\K[0-9]+(?=%)')
echo $v
