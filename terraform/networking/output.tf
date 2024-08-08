output "vpc_id" {
  value = aws_vpc.client-vpc.id
}

output "cidr_public_subnet" {
  value = aws_subnet.client-pub-sub.*.id
}

output "cidr_private_subnet" {
  value = aws_subnet.client-prv-sub.*.id
}