#!/bin/sh
#################################################
# Author: Khanh Pham                            #
# Date: 16 Sep 2021                             #
#################################################

### Installation required packages #####
# - aws-cli
# - jq

### Functions
check_cmd() {
    ## Check aws-cli command
    which aws >/dev/null;
    if [ $? -eq 1 ]; then
        echo "!!! Need to install aws-cli command"
        echo "https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html"
        exit 1
    fi
    which jq >/dev/null;
    ## Check JSON Processor command
    if [ $? -eq 1 ]; then
        echo "!!! Need to install jq command"
        echo "https://stedolan.github.io/jq/download/"
        exit 1
    fi
    which git-remote-codecommit >/dev/null;
    ## Check aws git-remote-codecommit
    if [ $? -eq 1 ]; then
        echo "!!! Need to install git-remote-codecommit command"
        echo "https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html"
        exit 1
    fi
}
######################### Main Script ####################
### Check Parameter ###
if [ $# -lt 1 ]; then
    echo "Usage: $0 AWS_PROFILE\n"
    exit 1
fi
### Check required commands
check_cmd

### Variables
AWSProfile=$1
Repos=`aws codecommit list-repositories --region ap-southeast-2 --profile $AWSProfile | jq -r .repositories[].repositoryName`

for rpn in $Repos
do
	echo $rpn
    git clone codecommit::ap-southeast-2://$AWSProfile@$rpn
done