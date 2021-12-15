count=1000
instances=$(aws ec2 run-instances \
        --image-id ami-0029863845aafa9de \
        --instance-type t3.micro \
        --key-name canette \
        --security-group-ids sg-0a566a3\
        --count $count\ 
        --query "Instances[*].InstanceId" \
        --output text)
echo "waiting for $instances"
echo $instances > instances.txt

for instance in $instances; do
        aws ec2 wait instance-status-ok --instance-ids $instance
        sleep 15
        ip=$(aws ec2 describe-instances --instance-ids $instance --query "Reservations[*].Instances[0].PublicIpAddress" --output text)
        echo "recording $instance $ip"
        docker run -d -v $PWD:/out widerin/vnc-recorder --host $ip --port 5901 --password raspberry --crf 25 --outfile /out/$instance.mp4
done
