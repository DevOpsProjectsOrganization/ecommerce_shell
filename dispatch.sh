source common.sh
component=dispatch
dnf install golang -y
APP_PREREQ
go mod init dispatch
go get 
go build
SYSTEMD