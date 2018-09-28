#!/bin/bash
echo " "
echo "---Creating and configuring required networking resources from command line---"
echo " "
echo " "
#Getting name from user
echo "Enter the name for stack"
read stack_name

vpc_name="${stack_name}-csye6225-vpc"
internetgateway_name="${stack_name}-csye6225-InternetGateway"
routetable_name="${stack_name}-csye6225-public-route-table"
subnet1_name="${stack_name}-csye6225-subnet-1"
subnet2_name="${stack_name}-csye6225-subnet-2"
subnet3_name="${stack_name}-csye6225-subnet-3"

if [ $? -eq 0 ]; then 
    # create vpc
    vpcId=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query 'Vpc.VpcId' --output text)
    if [ $? -eq 0 ]; then
        aws ec2 create-tags --resources $vpcId --tags Key=Name,Value=$vpc_name 
        echo 'vpc created'
        #create subnet
        subnetId1=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.1.0/24 --query 'Subnet.SubnetId' --output text)
        subnetId2=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.2.0/24 --query 'Subnet.SubnetId' --output text)
        subnetId3=$(aws ec2 create-subnet --vpc-id $vpcId --cidr-block 10.0.3.0/24 --query 'Subnet.SubnetId' --output text)
        if [ $? -eq 0 ]; then
            aws ec2 create-tags --resources $subnetId1 --tags Key=Name,Value=$subnet1_name 
            aws ec2 create-tags --resources $subnetId2 --tags Key=Name,Value=$subnet2_name
            aws ec2 create-tags --resources $subnetId3 --tags Key=Name,Value=$subnet3_name   
            echo 'subnet created'
            #create internet gateway
            internetgatewayId=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
            if [ $? -eq 0 ]; then
                aws ec2 create-tags --resources $internetgatewayId --tags Key=Name,Value=$internetgateway_name
                aws ec2 attach-internet-gateway --internet-gateway-id $internetgatewayId --vpc-id $vpcId
                echo 'Internet Gateway created'
                #create route table
                routetableId=$(aws ec2 create-route-table --vpc-id $vpcId --query 'RouteTable.RouteTableId' --output text)
                if [ $? -eq 0 ]; then
                    aws ec2 create-tags --resources $routetableId --tags Key=Name,Value=$routetable_name
                    aws ec2 create-route --route-table-id $routetableId --destination-cidr-block 0.0.0.0/0 --gateway-id $internetgatewayId
                    echo 'Routetable created'
                else
                    echo "Not able to create Route table"
                    exit 1
                fi
            else 
                echo "Not able to create Internet Gateway"
                exit 1
            fi
        else
            echo "Not ableto create subnet"
            exit 1
        fi
    else
        echo "Not able to create VPC"
        exit 1
    fi
else
    echo "Enter the name"
    exit 1
fi