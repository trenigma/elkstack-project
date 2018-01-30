#!/bin/bash
REPO_NAME=$1
if [ $# -ne 1 ]; then
    echo $0: usage: $0 REPO_NAME
    exit 1
fi
$(aws ecr get-login --region [region-id])
docker build -t $REPO_NAME .
docker tag $REPO_NAME:latest <account-number>.dkr.ecr.us-west-2.amazonaws.com/$REPO_NAME:latest
docker push <account-number>.dkr.ecr.us-west-2.amazonaws.com/$REPO_NAME:latest