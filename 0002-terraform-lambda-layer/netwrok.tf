//resource "aws_vpc" "example" {
//  cidr_block = "10.1.0.0/16"
//  tags = {
//    Name = "my-vpc-resource"
//  }
//}
//resource "aws_subnet" "example" {
//  cidr_block = "10.1.1.0/24"
//  vpc_id     = aws_vpc.example.id
//  tags = {
//    Name = "my-subnet-resource"
//  }
//}
