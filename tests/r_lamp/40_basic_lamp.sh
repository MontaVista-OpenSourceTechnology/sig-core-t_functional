#!/bin/bash

# Author: Karanbir Singh <kbsingh@karan.org>
#	  Athmane Madjoudj <athmanem@gmail.com>
#	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - install a minimal lamp stack, and test it"

# MySQL
# starting with 5.10, we have to differ between mysql55 and mysql
if [ $centos_ver = 5 ]
then
  t_InstallPackage mysql55-mysql-server httpd mysql55-mysql php php-mysql wget
  t_ServiceControl mysql55-mysqld stop
elif [ $centos_ver = 6 ]
then
  t_InstallPackage httpd mysql mysql-server php php-mysql wget
elif [ $centos_ver = 7 ]
then
  t_InstallPackage httpd mysql mysql-server php php-mysqlnd wget
else
  t_InstallPackage httpd mariadb mariadb-server php php-mysqlnd wget
fi

if [ $centos_ver -ge 8 ]
then
  t_ServiceControl mariadb restart
else
  t_ServiceControl mysqld restart
fi
t_ServiceControl httpd restart

# Initializing a small MySQL db
cat >/tmp/mysql-QA.sql <<EOF
create database qatests;
use qatests;
create table tests (name varchar(20)) ;
grant all on qatests.* to 'centos'@'localhost' identified by 'qa';
flush privileges;
EOF

mysql </tmp/mysql-QA.sql
/bin/rm /tmp/mysql-QA.sql

# Creating a simple php query page to insert Data in the MySQL DB

cat >/var/www/html/mysql.php <<EOF
<?php
\$dbconnect = mysqli_connect("localhost","centos","qa");
if (!\$dbconnect)
  {
  die('Could not connect: ' . mysqli_error());
  }

mysqli_select_db(\$dbconnect, "qatests");

mysqli_query(\$dbconnect, "INSERT INTO tests (name)
VALUES ('mysqltest')");

mysqli_close(\$dbconnect);
?> 
EOF

####################################################
# testing
####################################################

curl -s  http://localhost/mysql.php 

t_Log "Performing basic LAMP test"
content=`echo "select * from qatests.tests where name='mysqltest'"|mysql -B --skip-column-names`

# Clean up
mysql -u root -e 'drop database qatests;'
service httpd stop

if [ "$content" = "mysqltest" ] ; then
	ret_val=0;
else
	ret_val=1;
fi

t_CheckExitStatus $ret_val
