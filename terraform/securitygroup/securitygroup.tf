resource "aws_security_group" "jenkins-terraform-sg" {
  vpc_id      = var.vpc_id
  name        = format("%s-terraform-sg", var.stack_env)
  description = "Enable port 22 and Port 80"

  ingress {
    description = "Allow remote SSH anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    description = "Allow HTTP traffic"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    description = "Allow HTTPS traffic"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    description = "Allowing outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-terraform-sg", var.stack_env)
  }
}

resource "aws_security_group" "jenkins-port-8080" {
  name        = format("%s-port-8080", var.stack_env)
  vpc_id      = var.vpc_id
  description = "Enabling Default port for Jenkins"

  ingress {
    description = "jenkins default port 8080"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  ingress {
    description = "Jenkins slave connectivity"
    from_port   = 50000
    to_port     = 50000
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
  }

  tags = {
    Name = format("%s-port-8080", var.stack_env)
  }
}