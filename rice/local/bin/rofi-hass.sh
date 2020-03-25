#!/bin/bash

source secrets 

hass-cli service call light.toggle \
	--arguments entity_id=$(hass-cli entity list | awk '{print $1}' | grep "light\." | rofi -dmenu)
