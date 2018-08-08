
NAMEOFSTACK=StackFromDevCS


. ../variables.txt


# Some magic to get the keys generated
ssh-keygen -f id_rsa -t rsa -N ''
gcc -o key main.c
PUBLIC_KEY_TEXT=`cat id_rsa.pub | ./key`

gcc -o parameters parseParameters.c
PARAMETER=`./parameters`

printf "\n\n\n Lets see if this works \n\n\n\n"



#echo $PUBLIC_KEY_TEXT
echo $PARAMETER
echo $username
echo $password

psm stack create -t Oracle-SOACS-DBCS-Template -n "$NAMEOFSTACK" -p publicKeyText:"${PUBLIC_KEY_TEXT}" backupStorageUser:"${username}" backupStoragePassword:"${password}" ${PARAMETER}



#psm stack create -t Oracle-SOACS-DBCS-Template -n TestStackFromDCS -p publicKeyText:"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0Knezir7oNf0J0IRyEesNW8nZS6TtLQ3ilhf45QsCew29qshb7qoSmZd8vgCYSuysNiABM1XwVjeaXQHwzcjhIrWZrXoEQQQ9uBD9aa4Z7nSEd3Q34HtETqVjsBWY3Ci/U2MwTjb2vMPvLoAW/esRrZBTJC4rG33HYBrWTo2KbzrhNQ7OwOB+ad8iFfujiSdt9TXBa15NBb21l1pzbIe2Hmhphp3gtQtmjkWNYlQt+RuLlpCU0J6bt/7ETNdR0B5h859ebUZX7RDlfytom/6U+2EfruS2D8y/iTiAIybyI7JFtDaTlMKzGnn+ePM+EW0X3e3awTqKStISkKf+/tqf" serviceName:TestingStack commonPwd:"Amli_605" createBackupContainer:true backupStorageUser:"shashwatpandey27@gmail.com" backupStoragePassword:"jakejakeKK15" backupStorageContainer:"https://shashwatast.us.storage.oraclecloud.com/v1/Storage-shashwatast/JaaS" dbBackupStorageContainer:"https://shashwatast.us.storage.oraclecloud.com/v1/Storage-shashwatast/DBaaS"
