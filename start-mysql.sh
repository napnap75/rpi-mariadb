#!/bin/bash
if [ ! -d "/var/lib/mysql/mysql" ]; then
  /usr/bin/mysql_install_db --user=mysql --rpm
  /usr/bin/mysql -e "insert into user set Host='%', User='root', Password='';" mysql
fi
if [ ! -d "/run/mysqld" ]; then
  mkdir /run/mysqld
  chown mysql:mysql /run/mysqld
fi
/usr/bin/mysqld --user=mysql
