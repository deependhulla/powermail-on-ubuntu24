#!/bin/bash

mkdir /home/groupoffice/ 2>/dev/null
chmod 777 /home/groupoffice/
chown -R www-data:www-data /home/groupoffice/

echo "Downloading Latest GroupOffice "


echo "deb http://repo.group-office.com/ twentyfivezero main" > /etc/apt/sources.list.d/groupoffice.list
wget -qO - https://repo.group-office.com/downloads/groupoffice.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/groupoffice.gpg

#for purchased Group-Office Professional licenses then make sure the SourceGuardian loader is installed. You can run this command to do all the work:
curl -s https://raw.githubusercontent.com/Intermesh/groupoffice/master/scripts/sg_install.sh | bash


apt-get update
systemctl stop cron

echo "groupoffice groupoffice/dbconfig-install boolean true" | debconf-set-selections
echo "groupoffice groupoffice/mysql/admin-pass password" | sudo debconf-set-selections
echo "groupoffice groupoffice/mysql/app-pass password" | sudo debconf-set-selections

apt-get install -y groupoffice
chown -R www-data:www-data /usr/share/groupoffice/

## cron with MAILTO blank
#/bin/cp -p files/groupoffice-cron /etc/cron.d/

## replace data folder location
sed -i "s|/var/lib/groupoffice|/home/groupoffice|"  /etc/groupoffice/config.php


## force backup incae script run on production by mistake , you have backup
#/usr/sbin/automysqlbackup

echo "Remove exisitng default groupoffice database "
echo "And install one with all Module enabled and IMAP Auth activated"
echo "with groupofficeadmin user and random password in : /usr/local/src/groupofficeadmin-pass"
echo "Y" | mariadb-admin drop groupoffice -uroot 1>/dev/null 2>/dev/null
mariadb-admin create groupoffice -uroot
/bin/cp -p files/groupoffice-db.sql /tmp/groupoffice-db-tmp.sql
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /tmp/groupoffice-db-tmp.sql
sed -i "s/mydomainname\.com/`hostname -d`/" /tmp/groupoffice-db-tmp.sql
mariadb groupoffice < /tmp/groupoffice-db-tmp.sql
/bin/rm -rf /tmp/groupoffice-db-tmp.sql 1>/dev/null 2>/dev/null

##groupofficeadmin password set
GOPASSVPOP=`pwgen -c -1 8`
echo $GOPASSVPOP > /usr/local/src/groupofficeadmin-pass

php /usr/local/src/groupoffice65-groupofficeadmin-password-reset.php


sudo -u www-data php /usr/share/groupoffice/cli.php core/System/upgrade
echo "GroupOffice Uptodate done.."
## please get dovecot FTS setup done too
#echo "\$config['email_allow_body_search'] = true;" >> /etc/groupoffice/config.php
systemctl start cron
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /usr/local/src/cert-renew-and-restart.sh

systemctl restart apache2

echo "GroupOffice Setup Done"

