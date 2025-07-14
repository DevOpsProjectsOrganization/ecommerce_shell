if [-z $1]; then
    echo Input password is missing
    exit 1
fi
# if input is missing, we exit with an error of 1, but does not continue with the rest of the script  
source common.sh
component=shipping
MAVEN