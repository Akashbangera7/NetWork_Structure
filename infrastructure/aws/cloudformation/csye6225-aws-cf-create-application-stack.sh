echo " "
echo "---Creating Application Stack---"
echo " "
echo "Enter Keyname"
read keyname
echo " "
echo "Enter the name for application stack"
read stack_name
echo " "
echo "Enter the name for networking stack"
read network_stack
echo " "
stack=$(aws cloudformation describe-stacks --stack-name $network_stack --query Stacks[0].StackId --output text)
vpc_name="${network_stack}-csye6225-vpc"
vpcId=$(aws ec2 describe-vpcs --filters "Name=tag:aws:cloudformation:stack-id,Values=$stack" --query 'Vpcs[0].VpcId' --output text)
subnet1_name="${network_stack}-csye6225-public-subnet-1"
subnet2_name="${network_stack}-csye6225-public-subnet-2"
subnet3_name="${network_stack}-csye6225-public-subnet-3"
subnet1=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$subnet1_name" --query 'Subnets[0].SubnetId' --output text)
subnet2=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$subnet2_name" --query 'Subnets[0].SubnetId' --output text)
subnet3=$(aws ec2 describe-subnets --filters "Name=tag:Name,Values=$subnet3_name" --query 'Subnets[0].SubnetId' --output text)
echo " "
echo "vpcName : $vpc_name"
echo "vpcId : $vpcId"
echo "subnet1 : $subnet1_name"
echo "subnet1 : $subnet1"
echo "subnet2 : $subnet2_name"
echo "subnet2 : $subnet2"
echo "subnet3 : $subnet3_name"
echo "subnet3 : $subnet3"
echo " "
echo "Enter Storage size for RDS (Recommended less than 15)"
read allocatedStorage
echo "Enter Master username for RDS instance (csye6225master)"
read usernameRds
echo "Enter Master password for RDS instance (csye6225password)"
read passwordRds
echo " "
create_stack=$(aws cloudformation create-stack --stack-name $stack_name --template-body file://csye6225-cf-application.json --parameters ParameterKey=KeyName,ParameterValue=$keyname ParameterKey=vpcId,ParameterValue=$vpcId ParameterKey=subnet1,ParameterValue=$subnet1 ParameterKey=subnet2,ParameterValue=$subnet2 ParameterKey=subnet3,ParameterValue=$subnet3 ParameterKey=allocatedStorage,ParameterValue=$allocatedStorage ParameterKey=usernameRds,ParameterValue=$usernameRds ParameterKey=passwordRds,ParameterValue=$passwordRds)
if [ $? -eq 0 ]; then
  echo "Creating Stack ${stack_name} "
  aws cloudformation wait stack-create-complete --stack-name $stack_name
  echo "Stack created successfully"
else
  echo "Failure while creating stack"
fi