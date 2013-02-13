#!/bin/sh

if [ $# -lt "1" ]
then
    echo "Usage: $0 branch_name [push]"
    exit
fi

BRANCH=$1
PUSH=$2
CURLOPTS="--silent --user-agent \"\""
CURL=/usr/bin/curl

echo "Fetching https://clientarea.ramnode.com/privacy.php"
$CURL $CURLOPTS --output privacy https://clientarea.ramnode.com/privacy.php
echo "Fetching https://clientarea.ramnode.com/aup.php"
$CURL $CURLOPTS --output aup https://clientarea.ramnode.com/aup.php

git checkout -B "$BRANCH"
git add privacy aup
git commit -m "`date`"
git checkout -

if [ "$PUSH" != "" ]
then
    echo "Pushing branch $BRANCH to origin."
    git push origin "$BRANCH"
fi
