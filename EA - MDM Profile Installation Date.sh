#!/bin/bash

# Enter your MDM Profile's Identifier
mdmProfileIdentifier=""

profilesList=$(profiles -C -v)

profileNumber=$(echo "$profilesList" | grep -F "profileIdentifier: $mdmProfileIdentifier" | awk -F "[][]" '{print $2}')

mdmProfileInfo=$(echo "$profilesList" | grep -F "_computerlevel[$profileNumber] attribute")

installDate=$(echo "$mdmProfileInfo" | grep -F "installationDate" | awk -F "installationDate: " '{print $2}')

realInstallDate=${installDate% +*}

echo "<result>$realInstallDate</result>"

exit 0