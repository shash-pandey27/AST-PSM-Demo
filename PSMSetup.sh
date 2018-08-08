. ./variables.txt
echo "{
	\"username\":\"$username\",
	\"password\":\"$password\",
	\"identityDomain\":\"$id\",
	\"outputFormat\":\"json\"
}" > psm-setup.json

psm setup -c psm-setup.json


echo "**************"
echo " "
echo "Setup complete"
echo " "
echo "**************"
