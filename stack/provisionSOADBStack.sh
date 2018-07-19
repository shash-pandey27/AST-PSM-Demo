cp ../variables.txt ./variables.txt
source variables.txt
export username password id region accountname


echo "Enter the name of the stack (Must be 10 to 30 characters)"
read NAME_OF_STACK

echo "Enter a password for your DB and SOA instances"
read STACK_PASSWORD

echo "Enter your Cloud Domain Username"
read DOMAIN_NAME


ssh-keygen -f id_rsa -t rsa -N ''

g++ main.cpp

PUBLIC_KEY_TEXT=`cat id_rsa.pub | ./a.out`

echo "\n\n\n Lets see if this works \n\n\n\n"


#echo $PUBLIC_KEY_TEXT

psm stack create -t Oracle-SOACS-DBCS-Template -n $NAME_OF_STACK -p publicKeyText:"$PUBLIC_KEY_TEXT" serviceName:$NAME_OF_STACK commonPwd:$STACK_PASSWORD createBackupContainer:true backupStorageUser:$username backupStoragePassword:$password backupStorageContainer:"https://`echo $accountname`.`echo $region`.storage.oraclecloud.com/v1/Storage-`echo $accountname`/JaaS" dbBackupStorageContainer:"https://`echo $accountname`.`echo $region`.storage.oraclecloud.com/v1/Storage-`echo $accountname`/DBaaS"



#psm stack create -t Oracle-SOACS-DBCS-Template -n TestingStack -p publicKeyText:"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0Knezir7oNf0J0IRyEesNW8nZS6TtLQ3ilhf45QsCew29qshb7qoSmZd8vgCYSuysNiABM1XwVjeaXQHwzcjhIrWZrXoEQQQ9uBD9aa4Z7nSEd3Q34HtETqVjsBWY3Ci/U2MwTjb2vMPvLoAW/esRrZBTJC4rG33HYBrWTo2KbzrhNQ7OwOB+ad8iFfujiSdt9TXBa15NBb21l1pzbIe2Hmhphp3gtQtmjkWNYlQt+RuLlpCU0J6bt/7ETNdR0B5h859ebUZX7RDlfytom/6U+2EfruS2D8y/iTiAIybyI7JFtDaTlMKzGnn+ePM+EW0X3e3awTqKStISkKf+/tqf" serviceName:TestingStack commonPwd:"Amli_605" createBackupContainer:true backupStorageUser:"shashwatpandey27@gmail.com" backupStoragePassword:"jakejakeKK15" backupStorageContainer:"https://shashwatast.us.storage.oraclecloud.com/v1/Storage-shashwatast/JaaS" dbBackupStorageContainer:"https://shashwatast.us.storage.oraclecloud.com/v1/Storage-shashwatast/DBaaS"
