#!/bin/sh

# Include Standard PATH for commands
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

# We do the check here because on 10.14 and earlier there are 6 columns in the routing table returned by netstat
# and on later versions there are only 4 columns. This avoids issues with grep being fed empty data from the awk { print $6 }.
activeInterfaceID=$(/usr/sbin/netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $6 }')

if [ -z "$activeInterfaceID" ]; then
	activeInterfaceID=$(/usr/sbin/netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $4 }')
	echo "Active Interface ID: \"$activeInterfaceID\""
else
	echo "Active Interface ID: \"$activeInterfaceID\""
fi

activeInterfaceName=$(/usr/sbin/networksetup -listnetworkserviceorder 2>&1 | grep "$activeInterfaceID" | sed -e "s/.*Port: //g" -e "s/,.*//g")

echo "<result>$activeInterfaceName</result>"