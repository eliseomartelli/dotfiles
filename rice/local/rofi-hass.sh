#!/bin/bash

# Cache file
FILE=~/.cache/hass

# Sources secrets file for hass-cli
source secrets

# If cache is not presenb
[ ! -f $FILE ] && hass-cli entity list 'light\.' > ~/.cache/hass

# Get a friendly name list and pipe it into rofi
FRIENDLY_NAME="$(cat $FILE |
    sed 's/  \+/;/g'|
    awk -F';' '{print $2}' |
    tail -n +2 |
    rofi -i -p -dmenu -format i)"

# Increment the index to count for the first line
FRIENDLY_NAME=$((FRIENDLY_NAME+2))

# Get the entity id
ENTITY_ID=$(cat $FILE | sed "${FRIENDLY_NAME}q;d"  | awk '{print $1}')

# Invoke a toggle
hass-cli service call light.toggle \
	--arguments entity_id=$(echo $ENTITY_ID)
