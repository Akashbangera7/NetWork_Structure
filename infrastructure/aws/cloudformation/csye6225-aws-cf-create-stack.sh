#!/bin/sh
#shell script to create AWS network infrastructures
echo " "
echo "---Creating AWS networking infrastructure---"
echo " "
echo "Enter the name for stack"
read stack_name
aws cloudformation create-stack --stack-name $stack_name --template-body file://csye6225-cf-networking.json
