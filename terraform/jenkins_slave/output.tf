output "ec2-instance-ip-slave" {
  value = aws_instance.jenkins-slave.public_ip
}

output "ec2-slave-instance-id" {
  value = aws_instance.jenkins-slave.id
}