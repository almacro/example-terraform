resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  vpc_id = "vpc-324ba04a"
  ingress {
    from_port   = 8999
    to_port     = 8999
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0ce21b51cb31a48b8"
  instance_type = "t3.nano"
  key_name      = "mocn-ng"

  subnet_id                   = "subnet-d3d796aa"
  vpc_security_group_ids      = [aws_security_group.instance.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nmap-ncat
              mkdir -p /var/www && cd /var/www
              echo "Hello, World" > index.html
              cat<<SCRIPT > server.sh
              #!/bin/bash
              while true; do
                printf 'HTTP/1.1 200 OK\n\n%s' "$(cat index.html)" | nc -l 8999
              done
              SCRIPT
              chmod +x server.sh
              pwd
              ls -F
              nohup /var/www/server.sh &
              EOF

  tags = {
    Name = "terraform-example"
  }
}
