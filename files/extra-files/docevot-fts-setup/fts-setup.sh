#!/bin/sh

BASEDIR=$(dirname $0)
cd $BASEDIR

##https://github.com/grosjo/fts-xapian

cp  14-fts-plugin.conf /etc/dovecot/conf.d/
cp  90-fts.conf /etc/dovecot/conf.d/
mkdir  /usr/libexec/dovecot

chmod 755  /usr/libexec/dovecot
cp /usr/share/doc/dovecot-core/examples/decode2text.sh /usr/libexec/dovecot

systemctl restart dovecot.service

echo "Dovecot Restarted .. check tail dovecot.log"

tail -n 10  /var/log/dovecot.log
#If this is not a fresh install of dovecot, you need to re-index your mailboxes:

####doveadm index -A -q \*
#With argument -A, it will re-index all mailboxes, therefore may take a while.
#With argument -q, doveadm queues the indexing to be run by indexer process. Remove -q if you want to index immediately.
#You shall put in a cron the following command (for daily run for instance) :

####doveadm fts optimize -A 
