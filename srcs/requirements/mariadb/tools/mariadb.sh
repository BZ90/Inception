#!/bin/sh

automate_secure_installation() {
    /usr/bin/expect <<EOF
        set timeout -1
        spawn mysql_secure_installation
        
        expect "Enter current password for root (enter for none):"
        send "\r"
        
        expect "Set root password?"
        send "y\r"
        
        expect "New password:"
        send "$MYSQL_ROOT_PASSWORD\r"
        
        expect "Re-enter new password:"
        send "$MYSQL_ROOT_PASSWORD\r"
        
        expect "Remove anonymous users?"
        send "y\r"
        
        expect "Disallow root login remotely?"
        send "n\r"
        
        expect "Remove test database and access to it?"
        send "y\r"
        
        expect "Reload privilege tables now?"
        send "y\r"
        
        expect eof
EOF
}

mysql_install_db

/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo "Database already exists"

else

unset PROMPT

automate_secure_installation

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root -p$MYSQL_ROOT_PASSWORD

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root -p$MYSQL_ROOT_PASSWORD

mysql -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"
