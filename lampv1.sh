#!/bin/bash
apt-get -y update

# set up a silent install of MySQL
dbpass=$1

export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# install the LAMP stack
apt-get -y install apache2 mysql-server php5 php5-mysql unzip git

git clone "https://github.com/santoshreddyspy13/terraform"

cd terraform

unzip redlog.zip

cp -R redlog/* /var/www/html/
apachectl restart

mysql -uroot -p$dbpass -e 'create database redlog'
mysql -uroot -p$dbpass redlog < redlog.sql
