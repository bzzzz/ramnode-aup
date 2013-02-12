#!/bin/sh

if [ $# -lt "1" ]
then
    echo "Usage: $0 branch_name [push]"
    exit
fi

BRANCH=$1
PUSH=$2
CURLOPTS=--silent --user-agent ""
CURL=/usr/bin/curl

$CURL $CURLOPTS --output privacy https://clientarea.ramnode.com/privacy.php
$CURL $CURLOPTS --output aup https://clientarea.ramnode.com/aup.php

if [ "`git diff`" != "" ]
then
    git checkout -B "$BRANCH"
    git add privacy aup
    git commit -m "`date`"
    git checkout -

    [ "$PUSH" != "" ] && git push origin "$BRANCH"
fi
