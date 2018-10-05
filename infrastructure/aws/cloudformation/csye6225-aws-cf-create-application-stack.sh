echo " "
echo "---Creating Application Stack---"
echo " "
echo "Enter the name for stack"
read stack_name
create_stack=$(aws cloudformation create-stack --stack-name $stack_name --template-body file://csye6225-cf-application.json)
if [ $? -eq 0 ]; then
  echo "Creating Stack ${stack_name} "
  aws cloudformation wait stack-create-complete --stack-name $stack_name
  echo "Stack created successfully"
else
  echo "Failure while creating stack"
fi
