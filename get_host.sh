#!/bin/bash
AWSD=$(command -v aws)

$AWSD --profile shaadiprod --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --filters "Name=tag:Name,Values=Photo Automation Crop Worker Spot" "Name=instance-state-name,Values=running" --output text > /tmp/host.txt 


for host in $(cat /tmp/host.txt)
do
       ssh -i /home/Vinay/internal.pem -q -o ConnectTimeout=3 ubuntu@"$host" "hostname"
       if [ $? != 0 ]; then
       $AWSD --profile shaadiprod --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId]' --filter "Name=private-ip-address,Values=$host" --output text > /tmp/id.txt 
       fi
done 

for id in $(cat /tmp/id.txt)
do
	echo "$AWSD --profile shaadiprod --region us-east-1 ec2 terminate-instances --instance-ids $id"

done