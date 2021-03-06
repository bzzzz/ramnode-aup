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

[ "`git branch --list \"$BRANCH\"`" = "" ] && git branch "$BRANCH"
git checkout -q "$BRANCH"
if [ "`git branch | grep \"*\" | cut -d \" \" -f 2`" != "$BRANCH" ]
then
    echo "Could not check out the $BRANCH branch. Aborting."
    exit
fi

echo "Fetching https://clientarea.ramnode.com/privacy.php"
$CURL $CURLOPTS --output privacy https://clientarea.ramnode.com/privacy.php
echo "Fetching https://clientarea.ramnode.com/aup.php"
$CURL $CURLOPTS --output aup https://clientarea.ramnode.com/aup.php

if [ "`git status --porcelain -- privacy aup`" != "" ]
then
    git status --porcelain -- privacy aup
    git add privacy aup
    git commit -m "`date`"
else
    echo "no changes"
fi

git checkout -

if [ "$PUSH" != "" ]
then
    echo "Pushing branch $BRANCH to origin."
    git push origin "$BRANCH"
fi
