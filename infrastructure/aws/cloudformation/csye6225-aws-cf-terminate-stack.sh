#!/bin/sh
#shell script to delete AWS stack
echo " "
echo "---Deleting stack---"
echo " "
echo " "
#Getting name from user
echo "Enter the name for stack"
read stack_name
aws cloudformation delete-stack --stack-name $stack_name

