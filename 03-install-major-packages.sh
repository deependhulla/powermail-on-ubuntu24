#!/bin/sh

## check again for update
apt update
## check if full-upgrade is pending - reapply.
apt -y  full-upgrade

CFG_HOSTNAME_FQDN=`hostname -f`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | sudo debconf-set-selections 
echo "phpmyadmin phpmyadmin/mysql/admin-pass password" | sudo debconf-set-selections 
echo "phpmyadmin phpmyadmin/mysql/app-pass password" | sudo debconf-set-selections


DEBIAN_FRONTEND=noninteractive

apt -y install vim chrony openssh-server screen net-tools git mc postfix   \
sudo wget curl ethtool iptraf-ng traceroute telnet rsyslog software-properties-common \
dirmngr parted gdisk apt-transport-https lsb-release ca-certificates iputils-ping \
python3-full debconf-utils pwgen xfsprogs iftop htop multitail net-tools elinks pssh apache2 \
python3-pylint-common pylint iptables-persistent build-essential gnupg2 zip rar unrar ftp php rsync unzip \
python3-pip libimage-exiftool-perl poppler-utils tnef whois libauthen-pam-perl php-zip \
libio-pty-perl libnet-ssleay-perl  lynx lynx-common perl-openssl-defaults  \
libapache2-mod-php  php-cli php-common php-imap php-ldap php-xml phpmyadmin tar \
gpg dovecot-dev git libxapian-dev libicu-dev libsqlite3-dev autoconf automake libtool pkg-config \
php-curl php-mbstring php-zip php-apcu php-gd php-imagick imagemagick mcrypt \
python3-venv memcached php-memcached php-bcmath dbconfig-common libapache2-mod-php php-intl \
expect php-mysql pv php-intl libdbd-mysql-perl certbot python3-certbot-apache  \
php-mailparse perl-doc mysqltuner catdoc imagemagick tesseract-ocr tesseract-ocr-eng \
poppler-utils exiv2 libnet-dns-perl libmailtools-perl php-mail-mime postfix-mysql \
isort dovecot-mysql dovecot-sieve dovecot-managesieved dovecot-imapd dovecot-pop3d \
dovecot-sieve dovecot-antispam dovecot-fts-xapian postfix-pcre postfwd  opendkim \
opendkim-tools xapian-tools recoll libdatetime-format-mail-perl fetchmail imapproxy \
spamassassin libgssapi-perl razor pyzor libencode-detect-perl libgeoip2-perl \
libnet-patricia-perl antiword libbsd-resource-perl libencoding-fixlatin-perl \
libconfig-yaml-perl libnet-ldap-perl libconvert-asn1-perl libbusiness-isbn-perl \
python3-pycodestyle pycodestyle libencoding-fixlatin-xs-perl liburi-encode-perl \
sendemail libtest-leaktrace-perl libdb5.3-dev nomarch libtest-leaktrace-perl \
php-json libsort-naturally-perl libfile-which-perl  libfile-homedir-perl \
libfile-homedir-perl libfile-which-perl libpath-class-perl libany-uri-escape-perl \
html2text qrencode libqrencode4 python3-pytest libcpan-changes-perl libcpan-distnameinfo-perl \
libcpan-meta-check-perl libdata-perl-perl libdata-section-perl \
automysqlbackup libexporter-tiny-perl libfile-pushd-perl libfile-slurp-perl \
libgetopt-long-descriptive-perl liblist-moreutils-perl libmaxminddb-dev \
liblist-moreutils-xs-perl liblocal-lib-perl libmodule-build-perl \
libmodule-cpanfile-perl libmodule-signature-perl libmoox-handlesvia-perl \
libparse-pmfile-perl libpod-markdown-perl libpod-readme-perl \
libsoftware-license-perl libstring-shellquote-perl libtype-tiny-perl \
libgeo-ipfree-perl libtype-tiny-xs-perl liburi-escape-xs-perl \
libclone-pp-perl libtest-requires-perl libtest-warnings-perl libtest-fatal-perl \
p7zip p7zip-full arj liblhasa0 lhasa libmspack0 cabextract pax libidn2-dev libdb-dev \
cpanminus libcompress-raw-zlib-perl libconvert-tnef-perl libfilesys-df-perl libinline-perl \
libyaml-pp-perl libxxx-perl libpegex-perl libinline-c-perl libinline-files-perl libmail-imapclient-perl \
libmath-bigint-perl libole-storage-lite-perl libpod-simple-perl libsocket-perl libtest-harness-perl \
libtest-pod-perl libtest-simple-perl libsys-sigaction-perl libextutils-cbuilder-perl \
libnet-dns-resolver-programmable-perl libtest-manifest-perl libtext-balanced-perl libversion-perl \
libsendmail-pmilter-perl libmail-milter-perl libdevel-symdump-perl libpod-parser-perl libpod-coverage-perl \
libtest-pod-coverage-perl libfile-sharedir-install-perl libhtml-tokeparser-simple-perl geoip-database \
libgeoip1 libgeo-ip-perl libb-keywords-perl libdevel-cycle-perl libdevel-hide-perl libffi-checklib-perl \
libfile-chdir-perl libhook-lexwrap-perl libimporter-perl liblingua-en-inflect-perl libtask-weaken-perl \
libppi-perl libppix-quotelike-perl libppix-regexp-perl libppix-utilities-perl libpod-spell-perl \
libstring-format-perl perltidy libperl-critic-perl libsub-info-perl libsub-uplevel-perl libterm-size-perl-perl \
libterm-size-any-perl libterm-table-perl libtest-exception-perl libtest-failwarnings-perl libtest-file-perl \
libtest-nowarnings-perl libtest-object-perl libtest-regexp-perl libtest-subcalls-perl libtest2-suite-perl \
libtext-diff-perl libmce-perl libsereal-decoder-perl libsereal-encoder-perl libtest-perl-critic-perl \
clamav-base libclamav11 clamav-freshclam clamav-daemon bzip2-doc clamav clamdscan libbz2-dev \
libclamav-client-perl libssl-dev libtommath1 libtommath-dev libclamav-dev libtommath-doc 

systemctl restart chrony
echo > /var/log/mail.log
/bin/rm -rf /var/log/mail.info
/bin/rm -rf /var/log/mail.warn
/bin/rm -rf /var/log/mail.err

a2enmod actions > /dev/null 2>&1
a2enmod proxy_fcgi > /dev/null 2>&1
a2enmod fcgid > /dev/null 2>&1
a2enmod alias > /dev/null 2>&1
a2enmod suexec > /dev/null 2>&1
a2enmod rewrite > /dev/null 2>&1
a2enmod ssl > /dev/null 2>&1
a2enmod actions > /dev/null 2>&1
a2enmod include > /dev/null 2>&1
a2enmod dav_fs > /dev/null 2>&1
a2enmod dav > /dev/null 2>&1
a2enmod auth_digest > /dev/null 2>&1
a2enmod cgi > /dev/null 2>&1
a2enmod headers > /dev/null 2>&1
a2enmod proxy_http > /dev/null 2>&1
systemctl stop apache2

systemctl stop php8.3-fpm.service > /dev/null 2>&1
systemctl disable php8.3-fpm.service > /dev/null 2>&1
## keep fpm disabled default -- useful for very high load web-server
systemctl stop php.fpm  > /dev/null 2>&1
systemctl disable php-fpm > /dev/null 2>&1


### changing timezone to Asia Kolkata
sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.3/apache2/php.ini
sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.3/cli/php.ini
#sed -i "s/;date.timezone =/date\.timezone \= \'Asia\/Kolkata\'/" /etc/php/8.3/fpm/php.ini
##disable error
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.3/cli/php.ini
#sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.3/fpm/php.ini
sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ERROR/" /etc/php/8.3/apache2/php.ini

sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php/8.3/apache2/php.ini
sed -i "s/post_max_size = 100M/post_max_size = 800M/" /etc/php/8.3/apache2/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 800M/" /etc/php/8.3/apache2/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 100M/" /etc/php/8.3/apache2/php.ini


##disable this program as not needed , if got installed due to dependence
systemctl stop ModemManager 1>/dev/null 2>/dev/null
systemctl disable ModemManager 1>/dev/null 2>/dev/null
systemctl stop wpa_supplicant 1>/dev/null 2>/dev/null
systemctl disable wpa_supplicant 1>/dev/null 2>/dev/null

# use only for heavy load server via Service or use nginx
systemctl stop imapproxy.service 2>/dev/null
systemctl disable imapproxy.service 2>/dev/null

## for Debug need
#sed -i "s/#RateLimitIntervalSec=30s/RateLimitIntervalSec=0/"  /etc/systemd/journald.conf
#sed -i "s/#RateLimitBurst=10000/RateLimitBurst=0/"  /etc/systemd/journald.conf
#systemctl restart systemd-journald


sed -i "s/SOCKET\=local\:\$RUNDIR\/opendkim.sock/#SOCKET\=local\:\$RUNDIR\/opendkim.sock/" /etc/default/opendkim
sed -i "s/#SOCKET\=inet\:12345\@localhost/SOCKET\=inet\:12345\@localhost/" /etc/default/opendkim
/lib/opendkim/opendkim.service.generate
systemctl daemon-reload

##### configure proper timezone
#dpkg-reconfigure tzdata
##### configure locale proper
#dpkg-reconfigure locales
## set India IST time.
#/bin/rm -rf /etc/localtime
#/bin/ln -vs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
#### for adding firmware realtek driver
#apt install firmware-linux-nonfree
#apt install firmware-realtek
#update-initramfs -u
## only if VM notfor LXC
## for proxmox/kvm better preformance
#apt -y install qemu-guest-agent
## if on Consle need Mouse to use for copy paste use gpm
#apt install gpm
#google dns: [2001:4860:4860::8888]
#cloudflare dns: [2606:4700:4700::1111]

## for quick postfix queue management
/bin/cp -p files/extra-files/pfHandle /bin/

## safe backup
files/extra-files/etc-config-backup.sh

#apt -y install unbound 1>/dev/null 2>/dev/null
systemctl restart unbound 1>/dev/null 2>/dev/null
systemctl restart  rsyslog
systemctl stop nginx 1>/dev/null 2>/dev/null
systemctl restart  apache2
systemctl restart  cron
systemctl restart  mariadb

touch /var/log/dovecot.log
chmod 666 /var/log/dovecot.log

echo `hostname -f` > /etc/mailname
## adding 89 so that migration from qmailtoaster setup is easier.
groupadd -g 89 vmail 2>/dev/null
useradd -g vmail -u 89 -d /home/powermail vmail 2>/dev/null
mkdir /home/powermail 2>/dev/null
chown -R vmail:vmail /home/powermail

## if ZFS is used for Storage specailly for Archive Server
#DEBIAN_FRONTEND=noninteractive apt -y install zfs-dkms zfsutils-linux zfs-zed
#apt -y install dpkg-dev linux-headers-$(uname -r) linux-image-amd64

echo "Packages installed."


