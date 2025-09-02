#!/bin/sh


MYSQLPASSMAILW=`pwgen -c -1 8`
echo $MYSQLPASSMAILW > /usr/local/src/mariadb-mailscanner-pass

echo "Creating Database mailscanner for storing all logs for mailwatch"
mariadb-admin create mailscanner -uroot 1>/dev/null 2>/dev/null
mariadb < files/mailscanner-setup-files/MailWatch-1.2.23/create.sql 2>/dev/null
mariadb < files/mailscanner-setup-files/MailWatch-1.2.23/create.sql 2>/dev/null
#mariadb -f < files/mailscanner-setup-files/MailWatch-1.2.23/mailwatch-fix-for-subject-special-char-support.sql 2>/dev/null 
#mariadb -f < files/mailscanner-setup-files/MailWatch-1.2.23/mailwatch-extra.sql 2>/dev/null 
echo "GRANT ALL PRIVILEGES ON mailscanner.* TO mailscanner@localhost IDENTIFIED BY '$MYSQLPASSMAILW'" | mariadb -uroot
mariadb-admin -uroot reload
mariadb-admin -uroot refresh

MYSQLPASSMW=`pwgen -c -1 8`
echo $MYSQLPASSMW > /usr/local/src/mailwatch-admin-pass

echo "adding user mailwatch with password for gui access , password in /usr/local/src/mailwatch-admin-pass";
echo "DELETE FROM mailscanner.users WHERE \`username\` = 'mailwatch'" | mariadb ;
echo "INSERT INTO \`mailscanner\`.\`users\` (\`username\`, \`password\`, \`fullname\`, \`type\`, \`quarantine_report\`, \`spamscore\`, \`highspamscore\`, \`noscan\`, \`quarantine_rcpt\`) VALUES ('mailwatch', MD5('$MYSQLPASSMW'), 'Mail Admin', 'A', '0', '0', '0', '0', NULL);"  | mariadb;


touch /var/log/clamav/clamav.log 2>/dev/null
chmod 666 /var/log/clamav/clamav.log 2>/dev/null

/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/MailScanner_perl_scripts/*.pm /usr/share/MailScanner/perl/custom/

#/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Cron_jobs/*.php /usr/local/bin/
#/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Postfix_relay/*.php /usr/local/bin/

###/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Postfix_relay/mailwatch-postfix-relay /usr/local/bin/
##/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Postfix_relay/mailwatch-milter-relay /usr/local/bin/

#/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Postfix_relay/mailwatch-milter-relay-tail-process.sh /usr/local/bin/
#/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/tools/Cron_jobs/mailwatch /etc/cron.daily/
/bin/cp -pR files/mailscanner-setup-files/MailWatch-1.2.23/mailscanner /var/www/html/
#/bin/cp -pv files/mailscanner-setup-files/conf.php /var/www/html/mailscanner/
chown -R www-data:www-data /var/www/html/mailscanner/
chmod 666 /var/spool/MailScanner/incoming/SpamAssassin.cache.db 1>/dev/null 2>/dev/null

#sed -i "s/zaohm8ahC2/`cat /usr/local/src/mariadb-mailscanner-pass`/" /var/www/html/mailscanner/conf.php
sed -i "s/zaohm8ahC2/`cat /usr/local/src/mariadb-mailscanner-pass`/" /usr/share/MailScanner/perl/custom/MailWatchConf.pm
#sed -i "s/zaohm8ahC2/`cat /usr/local/src/mariadb-mailscanner-pass`/" /var/www/html/imagedata/index.php
#sed -i "s/zaohm8ahC2/`cat /usr/local/src/mariadb-mailscanner-pass`/" /var/www/html/mailscanner/detail.php
#sed -i "s/powermail\.mydomainname\.com/`hostname -f`/" /var/www/html/mailscanner/conf.php
#sed -i "s/powermail\.mydomainname\.com/`hostname -f`/"   /etc/MailScanner/MailScanner.conf
echo "Resarting mailscanner and msmilter service ...please wait..."
systemctl restart mailscanner msmilter.service 
##saferside chown
chmod 666 /var/spool/MailScanner/incoming/SpamAssassin.cache.db 2>/dev/null 1>/dev/null
#mysql < files/mailscanner-files/add-auth-track.sql 
#mysql < files/mailscanner-files/imageviewdata.sql 


echo "All Setup Done ,please reboot the Server once";
echo "Done."
