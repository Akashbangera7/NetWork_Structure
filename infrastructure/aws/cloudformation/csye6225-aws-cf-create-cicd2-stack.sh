#!/bin/sh
#shell script to create AWS cicd2 infrastructures
echo " "
echo "---Creating AWS ci/cd2 infrastructure---"
echo " "
echo "Enter the name of stack for deployment group"
  read stack_name2
  echo "Enter the name for instance "
  read instanceec
  echo "Enter the service Role ARN of CodeDeployServiceRole"
  read codedeployrole 
  create_stack1=$(aws cloudformation create-stack --stack-name $stack_name2 --template-body file://csye6225-cf-cicd2.json --capabilities CAPABILITY_NAMED_IAM --parameters ParameterKey=InstanceEC,ParameterValue=$instanceec ParameterKey=ServiceRole,ParameterValue=$codedeployrole)
if [ $? -eq 0 ]; then
  echo "Creating Stack ${stack_name2} "  
  aws cloudformation wait stack-create-complete --stack-name $stack_name2
  echo "Stack ${stack_name2} successfully"
  else
  echo "Failure while creating stack"
fi