# Data source to get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Data source to get the default subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Fetch the latest Ubuntu 22.04 LTS AMI using the AWS SSM Parameter Store
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/eks-pro/22.04/1.29/stable/20240410/amd64/hvm/ebs-gp2/ami-id"
}

# Create an EC2 instance in the default VPC and subnet
resource "aws_instance" "example1" {
  ami           = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.default.ids[0] # Use the first subnet from the default VPC

  tags = {
    Name = "MyEC2Instance1"
  }
}

resource "aws_instance" "example2" {
  ami           = data.aws_ssm_parameter.ubuntu_ami.value
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.default.ids[0] # Use the first subnet from the default VPC

  tags = {
    Name = "MyEC2Instance2"
  }
}
