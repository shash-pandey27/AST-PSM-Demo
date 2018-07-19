#sudo apt-get update
#sudo yum install python3-pip

sudo yum groupinstall "Development Tools"
sudo yum install zlib-devel

wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz
xz -d Python-3.6.5.tar.xz
tar -xvf Python-3.6.5.tar

cd Python-3.6.5/
./configure
make
make test
sudo make install
cd ..
sudo pip install --upgrade pip

echo "Enter your Cloud Account's Name"
read accountname

echo "Enter your Oracle Cloud Username: "
read user

echo "Enter your Oracle Cloud Password: "
read -s pass
echo "Enter your ID Domain: "
read id
echo "Enter your region (Valid values: us, emea, aucom)"
read region

sudo curl -X GET -u $user:$pass -H X-ID-TENANT-NAME:$id https://psm.us.oraclecloud.com/paas/core/api/v1.1/cli/$id/client -o psmcli.zip

sudo -H pip install -U psmcli.zip

echo "PSM has been installed successfully! Time for setup"

echo "{
	\"username\":\"$user\",
	\"password\":\"$pass\",
	\"identityDomain\":\"$id\",
	\"outputFormat\":\"json\"
}" > psm-setup.json

psm setup -c psm-setup.json

printf "accountname=$accountname\nusername=$user\npassword=$pass\nid=$id\nregion=$region\n" > variables.txt
