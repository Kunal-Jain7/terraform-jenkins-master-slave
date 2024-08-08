output "ec2-instance-ip-master" {
  value = aws_instance.jenkins-master.public_ip
}

output "ec2-instance-id" {
  value = aws_instance.jenkins-master.id
}