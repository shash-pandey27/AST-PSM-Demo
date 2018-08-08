source ../variables.txt
export username

. ./EHvariables.txt
ssh-keygen -f id_rsa -t rsa -N ''

g++ main.cpp

PUBLIC_KEY_TEXT=`cat id_rsa.pub | ./a.out`


echo "
{
	\"vmPublicKeyText\":\"$PUBLIC_KEY_TEXT\",
	\"userName\":\"$USER_NAME\",
	\"userPassword\":\"$USER_PASSWORD\",
	\"serviceName\":\"$SERVICE_NAME\",
	\"serviceLevel\":\"PAAS\",   
	\"meteringFrequency\":\"HOURLY\",
	\"serviceVersion\":\"0.10\",
	\"edition\":\"EE\",
	\"enableNotification\":\"true\",
	\"notificationEmail\":\"$username\",
	\"isBYOL\":\"false\",
	\"components\":{
		\"kafka\":{
			\"shape\":\"oc1m\",
			\"dataStorage\":\"50\",
			\"kafkaZkClusterSize\":\"1\",
			\"deploymentType\":\"Basic\",
			\"shape\":\"oc1m\"
		},
		\"restprxy\":{
			\"createRestprxy\":\"true\",
			\"restprxyShape\":\"oc1m\",
			\"restprxyClusterSize\":\"1\"
		},
		\"connect\":{
			\"createConnect\":\"true\",
			\"connectShape\":\"oc1m\",
			\"connectClusterSize\":\"1\"
		}
	}
}" > EHD-Template.json



echo "{
	\"numPartitions\":\"2\",
	\"retentionPeriod\":\"24\",
	\"systemName\":\"$SERVICE_NAME\",
	\"serviceName\":\"$TOPIC_NAME\",
	\"serviceLevel\":\"PAAS\",
	\"serviceVersion\":\"0.10\",
}" > EH-Template.json


psm OEHPCS create-service -c EHD-Template.json -wc true
psm OEHCS create-service -c EH-Template.json -wc true

