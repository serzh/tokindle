#!/bin/sh
# Script for sending documents to Kindle from shell

SMTP_HOST='smtp.gmail.com:587'
SMTP_USER='example@gmail.com'
FROM='example@gmail.com'
TO='example@gmail.com'

read -s -p "Enter password: " PASSWORD
echo "" | \
    mailx -v -s "" -a "$1" \
    -S smtp-use-starttls \
    -S ssl-verify=ignore \
    -S smtp-auth=login \
    -S smtp="$SMTP_HOST" \
    -S smtp-auth-user="$SMTP_USER" \
    -S smtp-auth-password="$PASSWORD" \
    -S from="$FROM" \
    $TO
