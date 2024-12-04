variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR block da VPC principal."
}

variable "availability_zones" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "aws_iam_labrole_arn" {
    type = string
    description = "ARN do role "
}