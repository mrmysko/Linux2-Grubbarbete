#!/bin/bash

# Backup storage directory 
backupfolder=/mnt/mysql_backups

# MySQL user
user=root

# MySQL password 
password=mysql_password

# Number of days to store the backup 
keep_day=2 

sqlfile=$backupfolder/all-databases-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/all-databases-$(date +%d-%m-%Y_%H-%M-%S).zip 

# Create a backup 
sudo mysqldump --host=172.20.0.3 -u $user -p$password --all-databases > $sqlfile 

if [ $? == 0 ]; then
  echo 'Sql dump created' 
else
  echo 'mysqldump return non-zero code' |  'No backup was created!'   
  exit 
fi 

# Compress backup 
zip $zipfile $sqlfile 
if [ $? == 0 ]; then
  echo 'The backup was successfully compressed' 
else
  echo 'Error compressing backup' |  'Backup was not created!' 
  exit 
fi 
rm $sqlfile 
echo $zipfile 'Backup was successfully created'  

# Delete old backups 
find $backupfolder -mtime +$keep_day -delete
