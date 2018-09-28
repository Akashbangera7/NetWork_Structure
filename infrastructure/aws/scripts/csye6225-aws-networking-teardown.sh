#!/bin/bash
echo " "
echo "---Deleting networking resources from command line---"
echo " "
echo " "
#Getting name from user
echo "Enter the name for stack"
read stack_name


vpc_name="${stack_name}-csye6225-vpc"
vpcId=$(aws ec2 describe-vpcs --query "Vpcs[*].[VpcId,Tags[0].Value]" --output text |grep $vpc_name| awk '{print $1}' )
if [ $? -ne 0 ]; then
    internetgateway_name="${stack_name}-csye6225-InternetGateway"
    routetable_name="${stack_name}-csye6225-public-route-table"
    subnet1_name="${stack_name}-csye6225-subnet-1"
    subnet2_name="${stack_name}-csye6225-subnet-2"
    subnet3_name="${stack_name}-csye6225-subnet-3"

    #routetableId=$(aws ec2 create-route-table --vpc-id $vpcId --query 'RouteTable.RouteTableId' --output text)

    internetgatewayId=$(aws ec2 describe-internet-gateways --query "InternetGateways[*].[InternetGatewayId,Tags[0].Value]" --output text |grep $internetgateway_name| awk '{print $1}' )
    routetableId=$(aws ec2 describe-route-tables --query "RouteTables[*].[RouteTableId,Tags[0].Value]" --output text |grep $routetable_name| awk '{print $1}' )
    subnetId1=$(aws ec2 describe-subnets --query "Subnets[*].[SubnetId,Tags[0].Value]" --output text |grep $subnet1_name| awk '{print $1}' )
    subnetId2=$(aws ec2 describe-subnets --query "Subnets[*].[SubnetId,Tags[0].Value]" --output text |grep $subnet2_name| awk '{print $1}' )
    subnetId3=$(aws ec2 describe-subnets --query "Subnets[*].[SubnetId,Tags[0].Value]" --output text |grep $subnet3_name| awk '{print $1}' )

    #deleting internet gateway
    aws ec2 detach-internet-gateway --internet-gateway-id $internetgatewayId --vpc-id $vpcId
    aws ec2 delete-internet-gateway --internet-gateway-id $internetgatewayId
    if [ $? -eq 0 ]; then
        echo "internet gateway deleted"
    else
        echo"internet gateway not deleted"
    fi

    #deleting route table
    aws ec2 delete-route-table --route-table-id $routetableId
    if [ $? -eq 0 ]; then
        echo "route table deleted"
    else
        echo "route table not deleted"
    fi

    #deleting subnet
    aws ec2 delete-subnet --subnet-id $subnetId1
    aws ec2 delete-subnet --subnet-id $subnetId2
    aws ec2 delete-subnet --subnet-id $subnetId3
    if [ $? -eq 0 ]; then
        echo "subnet deleted"
    else
        echo "subnet not deleted"
    fi

    #deleting virtual private cloud
    aws ec2 delete-vpc --vpc-id $vpcId
    if [ $? -eq 0 ]; then
        echo "vpc deleted"
    else
        echo "vpc not deleted"
    fi
else
    echo "stack_name doesn't exist"
fi