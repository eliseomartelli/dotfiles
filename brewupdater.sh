#!/bin/bash

BREW='/opt/homebrew/bin/brew'

notify ()
{
	osascript -e 'display notification "Updates Available" with title "Homebrew"'
}

$BREW update > /dev/null
outdated=$($BREW outdated --quiet | tr ' ' '\n')

if [ ! -z "$outdated" ]; then
	notify
fi
