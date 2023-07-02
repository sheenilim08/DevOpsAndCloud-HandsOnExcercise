#!/usr/bin/env bash

# update package
sudo yum -y update

# install git
sudo yum -y  install git

# install SSM
sudo yum -y  install https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#sudo systemctl start amazon-ssm-agent

# install cloudwatch agent
sudo yum -y install https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status

# install AWS inspector
curl -O https://inspector-agent.amazonaws.com/linux/latest/install
sudo bash install
