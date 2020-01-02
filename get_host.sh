#!/bin/bash
AWSD=$(command -v aws)

$AWSD --profile shaadiprod --region us-east-1 ec2 describe-instances --query 'Reservations[*].Instances[*].[PrivateIpAddress]' --filters "Name=tag:Name,Values=Photo Automation Crop Worker Spot" "Name=instance-state-name,Values=running" --output text >> /tmp/host.txt 
