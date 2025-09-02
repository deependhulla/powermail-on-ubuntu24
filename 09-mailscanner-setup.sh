#!/bin/sh

wget https://github.com/MailScanner/v5/releases/download/5.5.3-2/MailScanner-5.5.3-2.noarch.deb.sig -O /tmp/MailScanner-5.5.3-2.noarch.deb.sig
wget https://github.com/MailScanner/v5/releases/download/5.5.3-2/MailScanner-5.5.3-2.noarch.deb -O /tmp/MailScanner-5.5.3-2.noarch.deb
wget https://github.com/MailScanner/v5/releases/download/5.5.3-2/MailScanner-5.5.3-2.nix.tar.gz -O /opt/MailScanner-5.5.3-2.nix.tar.gz

dpkg -i /tmp/MailScanner-5.5.3-2.noarch.deb

/usr/sbin/ms-configure --MTA=postfix --installClamav=Y --installCPAN=Y --ramdiskSize=0 --installUnrar=Y



##backup Message.pm as we are updating with Opentrack URL-Images and Outlook Vcal fix.
/bin/cp /usr/share/MailScanner/perl/MailScanner/Message.pm /usr/local/src/MailScanner-Orginal-Message-`date +%s`.pm 
/bin/cp /usr/share/MailScanner/perl/MailScanner/MSDiskStore.pm /usr/local/src/MailScanner-Orginal-MSDiskStore-`date +%s`.pm

## allow http://lists.mailscanner.info/pipermail/mailscanner/2012-February/099106.html
## 
## Edit the AppArmor profile
## /etc/apparmor.d/usr.sbin.clamd
## Add these 2 lines:
##  /var/spool/MailScanner/** rw,
##  /var/spool/MailScanner/incoming/** rw,
## Then, reload AppArmor /etc/init.d/apparmor reload
## Else Error : clam  : lstat() failed on: /var/spool/MailScanner/incoming/
#/bin/cp -pRv files/mailscanner-files/usr.sbin.clamd /etc/apparmor.d/



# VCALENDAR outlook fix in mailscanner ..calender not working ok.
# Added the Code in : 
# /usr/share/MailScanner/perl/MailScanner/MSDiskStore.pm
# 
#  diff MSDiskStore-v5.pm MSDiskStore.pm
# 299,300d298
# <       # Newline separation between header and body was missing here for VCALENDAR
# <       $Tf->print("\n"); 
#########
# IT LOOK LIKE THIS:
# 
# } elsif ($this->{body}[0] eq "MIME") {
#      my ($type, $id, $entity, $outq)= @{$this->{body}};
#      # This needs re-writing, as we need to massage every line
#      # Newline separation between header and body was missing here for VCALENDAR
#      $Tf->print("\n");
#
#      # Create a pipe to squirt the message body through
# 
 #######​
 
systemctl restart apparmor.service 2>/dev/null 

sed -i "s/run_mailscanner=0/run_mailscanner=1/" /etc/MailScanner/defaults 
#/bin/cp -p files/mailscanner-files/header_checks /etc/postfix/header_checks

##/bin/cp -p files/mailscanner-files/clamd.conf /etc/clamav/

touch /etc/MailScanner/archives.filetype.rules.conf
touch /etc/MailScanner/archives.filename.rules.conf
touch /etc/MailScanner/filename.rules.conf
mkdir /var/spool/MailScanner/incoming 2>/dev/null
mkdir /var/spool/MailScanner/quarantine 2>/dev/null
mkdir /var/spool/MailScanner/incoming/Locks 2>/dev/null
chown postfix:postfix /var/spool/MailScanner/incoming
chown postfix:postfix /var/spool/MailScanner/quarantine
chown postfix:root /var/spool/postfix/

## for Update
#chown -R postfix:mtagroup /var/spool/MailScanner/milterin
#chown -R postfix:mtagroup /var/spool/MailScanner/milterout
#chown -R postfix:postfix /var/spool/MailScanner/quarantine
## Check version
#perl -MSendmail::PMilter -le 'print $Sendmail::PMilter::VERSION'

#/bin/cp -pRv files/mailscanner-files/ms-etc/* /etc/MailScanner/

## so that mailwatch can read
chmod 744 /var/spool/postfix/incoming/
chmod 744 /var/spool/postfix/hold/
chown -R postfix  /var/log/clamav 2>/dev/null
/bin/cp -pR files/mailscanner-rootdir/* /
sed -i "s/powermail\.mydomainname\.com/`hostname -f`/"   /usr/share/MailScanner/perl/MailScanner/Message.pm

## Mail-Archive Tool
mkdir /archivedata
mkdir /archivedata/mail-archive-uncompress 2>/dev/null
mkdir /archivedata/mail-archive-compress 2>/dev/null
mkdir /archivedata/mail-archive-process 2>/dev/null
chmod 777 /archivedata
chmod 777 /archivedata/mail-archive-uncompress
chmod 777 /archivedata/mail-archive-compress
chmod 777 /archivedata/mail-archive-process

touch /var/log/clamav/clamav.log 2>/dev/null
chmod 666 /var/log/clamav/clamav.log 2>/dev/null

chmod 666 /var/spool/MailScanner/incoming/SpamAssassin.cache.db 1>/dev/null 2>/dev/null

sed -i "s/powermail\.mydomainname\.com/`hostname`/"   /etc/MailScanner/MailScanner.conf

echo "Resarting all service ...please wait..."
systemctl restart dovecot
systemctl restart opendkim
#systemctl restart clamav-daemon 2>/dev/null
#systemctl restart cron

##force one more time
chmod 666 /var/spool/MailScanner/incoming/SpamAssassin.cache.db 2>/dev/null 1>/dev/null

## For Updating All Perl Extra Module to Latest Version
/usr/sbin/ms-configure --update

systemctl enable postfix
systemctl restart postfix
systemctl enable mailscanner
systemctl stop mailscanner
systemctl start mailscanner
systemctl enable msmilter
systemctl stop msmilter
systemctl start msmilter

echo "Done."
