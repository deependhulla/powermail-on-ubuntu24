#!/usr/bin/expect -f

set timeout 10

spawn  mariadb-secure-installation

expect "Enter current password for root (enter for none):"
send "\r"

expect "Switch to unix_socket authentication [Y/n]"
send "N\r"

expect "Change the root password? [Y/n]"
send "N\r"


expect "Remove anonymous users? [Y/n]"
send "Y\r"

expect "Disallow root login remotely? [Y/n]"
send "Y\r"

expect "Remove test database and access to it? [Y/n]"
send "Y\r"

expect "Reload privilege tables now? [Y/n]"
send "Y\r"

interact
