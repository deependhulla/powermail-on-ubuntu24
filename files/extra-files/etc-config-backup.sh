#!/bin/sh
echo "";
mkdir /opt/etc-backup-files/ 2>/dev/bull
chmod 600 /opt/etc-backup-files
## for safety purpose backup of orginal config
FOLDERX=`date +%Y_%m_%d_%H_%M_%S`
echo -n copying in /opt/etc-backup-files/etc-bk-$FOLDERX ...
/bin/cp -pR /etc /opt/etc-backup-files/etc-bk-$FOLDERX
echo -n .done.
echo "";
