
#!/bin/bash

# Safety feature: exit script if error is returned, or if variables not set.
# Exit if a pipeline results in an error.
set -ue
set -o pipefail

# if the first input is empty then run the command on both regions
if [ -z ${1+x} ]; then

  REGION=( us-east-1 us-west-1 )

  for i in "${REGION[@]}"
   do
    aws ec2 describe-instances --region $i --query 'Reservations[].Instances[].[Tags[?Key==`Name`] | [0].Value,State.Name,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone]' --output=table;
  done

  exit 1

fi

# if first input is -h then display message
if [ "$1" == "-h" ]; then
  echo ""
  echo "### Description ###"
  echo "`basename $0` displays specified instances in a table"
  echo "if an option is left out, then it will include all"
  echo ""
  echo "### Flags ###"
  echo " -h     display help "
  echo ""
  echo "### Options ####"
  echo "Region - {us-east-1,us-west-1}"
  echo "Environment - {Prod,Pilot,Stage}"
  echo "Type - {LOG,HTTPD,APP}"
  echo ""
  echo "### Examples ###"
  echo "`basename $0` {Region} {Environment} {Type}"
  echo ""
  exit 1
fi

# if the second input is empty then run the command on specified region
if [ -z ${2+x} ]; then

  REGION=$1

  aws ec2 describe-instances --region $REGION --query 'Reservations[].Instances[].[Tags[?Key==`Name`] | [0].Value,State.Name,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone]' --output=table;

  exit 1

#if the third input is empty then run the command on the specified region and tag
elif [ -z ${3+x} ]; then

  REGION=$1
  ENVIR=$2

  aws ec2 describe-instances --region $REGION --query 'Reservations[].Instances[].[Tags[?Key==`Name`] | [0].Value,State.Name,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone]' --filters "Name=tag:Environment,Values=$ENVIR" --output=table;

  exit 1

# else assume three input's and run the command on specified region and tags
else

  REGION=$1
  ENVIR=$2
  TYPE=$3

  aws ec2 describe-instances --region $REGION --query 'Reservations[].Instances[].[Tags[?Key==`Name`] | [0].Value,State.Name,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone]' --filters "Name=tag:Environment,Values=$ENVIR" "Name=tag:Server Type,Values=$TYPE" --output=table

fi


