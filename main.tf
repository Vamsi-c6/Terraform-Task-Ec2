
data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group-Vamsi"   
  description = "Allow SSH, HTTP, and custom 8080"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = "t2.micro"
  key_name               = var.Vamsi
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  # Optional: install Apache and start a simple 8080 server so you can test immediately
  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y apache2 python3
    systemctl enable --now apache2
    nohup python3 -m http.server 8080 >/tmp/http8080.log 2>&1 &
  EOF

  tags = {
    Name = "Vamsi-terraform-EC2-Lab-Ubuntu"
  }
}
