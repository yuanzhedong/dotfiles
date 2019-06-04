#! /bin/sh
 
if [[ -z "$1" ]]; then
  echo "Usage: ./aws_connect.sh (ec2-instance id[i-0?????])"
  exit 1
fi
 
aws ec2 start-instances --instance-ids "$1" &> /dev/null
 
echo "Starting instance... wait for it"
 
# instance started
aws ec2 wait instance-running --instance-ids "$1"
INSTANCE_IP="$(aws ec2 describe-instances --instance-ids $1 --query "Reservations[].Instances[][PublicIpAddress]" --output text)"
echo "Instance is started with public ip: $INSTANCE_IP"
 
# wait for ssh
echo "Waiting for the instance to boot up before ssh"
aws ec2 wait instance-status-ok --instance-ids "$1"
 
echo "do some ssh connection here"
#ex: ssh -i ~/.ssh/somekey.pem -L 8888:localhost:8888 ubuntu@${INSTANCE_IP}
