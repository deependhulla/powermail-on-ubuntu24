#!/bin/bash


sed -i "s/LimitNOFILE=10000/LimitNOFILE=62768/"   /usr/lib/systemd/system/mysql.service
systemctl daemon-reload

MYSQLPASSVPOP=`pwgen -c -1 8`
echo $MYSQLPASSVPOP > /usr/local/src/mysql-mydbadmin-pass
echo "mydbadmin password in /usr/local/src/mysql-mydbadmin-pass"

## for mariadb -
##echo "GRANT ALL PRIVILEGES ON *.* TO mydbadmin@localhost IDENTIFIED BY '$MYSQLPASSVPOP'" with grant option | mysql -uroot

## for mysql 8+ 
#In MySQL 8.0 and later, the GRANT statement no longer implicitly creates a user if the user does not exist. You need to explicitly create the user first using the CREATE USER statement, and then grant privileges.

echo "CREATE USER 'mydbadmin'@'localhost' IDENTIFIED BY '$MYSQLPASSVPOP';" | mysql -uroot
echo "GRANT ALL PRIVILEGES ON *.* TO 'mydbadmin'@'localhost' WITH GRANT OPTION;" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot




mysqladmin -uroot reload
mysqladmin -uroot refresh

systemctl restart  mysql

#mysqladmin -u root -ptmppassword status
#mysqladmin -u root -p extended-status
#mysqladmin -u root -p processlist

echo "Database Password Setup done."
