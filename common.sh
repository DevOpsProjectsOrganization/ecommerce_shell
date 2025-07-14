SYSTEMD(){
systemctl daemon-reload
systemctl enable ${component}
systemctl start ${component}
}

APP_PREREQ(){
useradd roboshop
cp -f ${component}.service /etc/systemd/system/${component}.service
rm -rf /app
mkdir /app 
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}-v3.zip 
cd /app 
unzip /tmp/${component}.zip
cd /app 
}

NODEJS(){
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

APP_PREREQ
npm install

SYSTEMD
}

MAVEN(){

dnf install maven -y

APP_PREREQ
mvn clean package 
mv target/${component}-1.0.jar ${component}.jar  
dnf install mysql -y 
# here the password is the first argument that is sent while running the shipping.sh and 
#hence it is not hardcoded in the code.
# sudo bash shipping.sh RoboShop@1
for word in schema app-user master-data; do
mysql -h mysql-dev.sdevops.shop -uroot -p$1 < /app/db/${word}.sql
done

SYSTEMD
}


PYTHON(){
dnf install python3 gcc python3-devel -y

APP_PREREQ
pip3 install -r requirements.txt

SYSTEMD
}