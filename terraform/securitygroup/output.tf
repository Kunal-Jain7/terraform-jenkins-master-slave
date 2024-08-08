output "jenkins-8080-id" {
  value = aws_security_group.jenkins-port-8080.id
}

output "jenkins-terraform-sg-id" {
  value = aws_security_group.jenkins-terraform-sg.id
}