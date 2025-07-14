cp -f mongo.repo /etc/yum.repos.d/mongo.repo

source common.sh
component=catalogue
NODEJS

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.sdevops.shop </app/db/master-data.js

