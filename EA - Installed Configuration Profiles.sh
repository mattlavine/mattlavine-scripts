#!/bin/sh

# Displays all configuration profiles installed

profiles=`/usr/bin/profiles -C -v | awk -F: '/attribute: name/' | sed -n -e 's/^.*attribute: name: //p' | sort | sed -e 's/^[ \t]*//'`

if [[ ! -z "$profiles" ]]; then
	echo "<result>$profiles</result>"
else
	echo "<result>Not Installed</result>"
fi

exit 0