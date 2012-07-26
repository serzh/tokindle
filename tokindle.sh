#!/bin/sh
# Script for sending documents to Kindle from shell

SMTP_HOST='smtp.gmail.com:587'
SMTP_USER='example@gmail.com'
FROM='example@gmail.com'
TO='example@kindle.com'
SUBJECT=''
CONVERT_SUBJECT='convert'

read -s -p "Enter SMTP password: " PASSWORD

while [ $# -gt 0 ]
do
    SUBJECT=''

    if [ $1 = "-c" ]
    then
        SUBJECT=$CONVERT_SUBJECT
        shift
    fi
    
    echo "\nSending $1..."

    echo "" | \
        mailx -s "$SUBJECT" -a "$1" \
        -S smtp-use-starttls \
        -S ssl-verify=ignore \
        -S smtp-auth=login \
        -S smtp="$SMTP_HOST" \
        -S smtp-auth-user="$SMTP_USER" \
        -S smtp-auth-password="$PASSWORD" \
        -S from="$FROM" \
        $TO

    shift
done
