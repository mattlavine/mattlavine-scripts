#!/bin/sh

# This extension attribute checks to see if the string "JamfConnectLogin" exists in the loginwindow mechanisms. This means that Jamf Connect is enabled.

loginmechanisms=`security authorizationdb read system.login.console`

if [[ "$loginmechanisms" == *"JamfConnectLogin"* ]]; then
	echo "<result>Enabled</result>"
else
	echo "<result>Disabled</result>"
fi

exit 0