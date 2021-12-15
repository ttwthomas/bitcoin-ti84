instances=$(cat instances.txt)
for instance in $instances; do
        ip=$(aws ec2 describe-instances --instance-ids $instance --query "Reservations[*].Instances[0].PublicIpAddress" --output text)
         /c/Program\ Files/TightVNC/tvnviewer.exe $ip::5901 -password="raspberry" &
done
