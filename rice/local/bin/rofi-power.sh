#!/bin/bash

lock="🔒 lock"
suspend="⏸️ suspend"
hibernate="🏔️ hibernate"
shutdown="🔌 shutdown"

MODE="$(echo -e "$lock\n$suspend\n$hibernate\n$shutdown" \
	| rofi -dmenu)"

case $MODE in
	$shutdown)  exec systemctl poweroff;;
	$suspend)   exec systemctl suspend;;
	$lock)	    exec light-locker-command -l;;
	$hibernate) exec systemctl hibernate;;
esac
