#!/bin/sh
# Script for sending documents to Kindle from shell

# Configuration block
# Change options in this block only!

# SMTP host address
SMTP_HOST='smtp.gmail.com:587'

# SMTP user name
SMTP_USER='example@gmail.com'

# SMTP password. Warnning! If you don't fill
# it you'll be asked for him.
# Do not fill it if you not sure that file will be secured!
PASSWORD=''

# Value of "from" field
FROM='example@gmail.com'

# The recipment
TO='example@kindle.com'

# End of configuration block

SUBJECT=''
CONVERT_SUBJECT='Convert'

if [ "$1" = "-h" ]
then
    echo "Usage:"
    echo "tokindle [-c] <filename> [[-c] <filename>].."
    echo "Where:"
    echo -e "  -c\t- convert file to mobi format"
    exit 0
fi

if [ "$PASSWORD" = "" ]
then
    read -s -p "Enter SMTP password: " PASSWORD
fi

while [ $# -gt 0 ]
do
    SUBJECT=''

    if [ "$1" = "-c" ]
    then
        SUBJECT=$CONVERT_SUBJECT
        shift
    fi
    
    echo "Sending $1..."

    echo "" | mailx \
        -s "$SUBJECT" \
        -a "$1" \
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
