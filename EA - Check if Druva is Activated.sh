#!/bin/sh

if [[ -d "/Applications/Druva inSync.app" ]]; then
	echo "Druva app exists. Proceeding..."
else
	echo "<result>Not Installed</result>"
	exit 0
fi

DOCK_PROCESS=$(pgrep -l "Dock")
if [[ "$DOCK_PROCESS" != "" ]]; then
	echo "Dock is running. Proceeding..."
else
	echo "Dock is not running yet. Exiting..."
	exit 1
fi

loggedInUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

if [[ "$loggedInUser" == "_mbsetupuser" ]]; then
	echo "Setup Assistant is still logged in. Exiting..."
	exit 2
fi


if [[ -f "/Users/$loggedInUser/Library/Application Support/inSync/inSync.cfg" ]]; then
	echo "inSync.cfg file exists. Proceeding..."
else
	echo "<result>Config Not Found</result>"
	exit 0
fi

email=$(grep -F "WRUSER" "/Users/$loggedInUser/Library/Application Support/inSync/inSync.cfg" | awk -F "'" '{print $2}')

echo "Email: \"$email\""

if [[ "$email" != "" ]]; then
	echo "User is Logged In"
	echo "<result>$email</result>"
else
	echo "No User is Logged In"
	echo "<result>User is Not Logged In</result>"
fi

exit 0