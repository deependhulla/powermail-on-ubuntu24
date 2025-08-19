#!/bin/bash

DEBIAN_FRONTEND=noninteractive

## if installed stop it -- normally not there
systemctl stop  mariadb 1>/dev/null 2>/dev/null

## get latest stable Version 11.8 LTS from direct mariadb
#cd /tmp
#curl -LsSO https://r.mariadb.com/downloads/mariadb_repo_setup

#remove old files ..exaqmple rerun
/bin/rm /etc/apt/sources.list.d/mariadb.lis* 1>/dev/null 2>/dev/null

curl -LsS https://r.mariadb.com/downloads/mariadb_repo_setup | sudo bash -s -- --mariadb-server-version="mariadb-11.8"

#Verify the checksum of the script:
#echo "${checksum} mariadb_repo_setup" | sha256sum -c -
## Reference and checksum code on -- https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/installing-mariadb/binary-packages/mariadb-package-repository-setup-and-usage

DEBIAN_FRONTEND=noninteractive
echo "mariadb-server	mariadb-server/feedback_optin	boolean	false" | debconf-set-selections

apt-get -y install mariadb-server mariadb-client mariadb-backup dbconfig-common
echo "---------------------------------------------------------------------";
echo "Make sure its MariaDB Server version is 11.x like 11.8 or above"
echo "---------------------------------------------------------------------";

 dpkg -l | grep mariadb
echo "---------------------------------------------------------------------";


systemctl stop  mariadb 1>/dev/null 2>/dev/null
/bin/cp -pRv files/powermail-rootdir/etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/ 
sed -i "s/LimitNOFILE=32768/LimitNOFILE=62768/"   /usr/lib/systemd/system/mariadb.service
systemctl daemon-reload
systemctl start mariadb

MYSQLPASSVPOP=`pwgen -c -1 12`
echo $MYSQLPASSVPOP > /usr/local/src/mariadb-mydbadmin-pass
echo "mydbadmin password in /usr/local/src/mariadb-mydbadmin-pass"

echo "GRANT ALL PRIVILEGES ON *.* TO mydbadmin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" with grant option | mariadb -uroot
mariadb-admin -uroot reload
mariadb-admin -uroot refresh

systemctl restart  mariadb

#mysqladmin -u root -ptmppassword status
#mysqladmin -u root -p extended-status
#mysqladmin -u root -p processlist

echo "Database Password Setup done."


