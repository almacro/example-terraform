resource "aws_instance" "example" {
  ami                         = "ami-0ce21b51cb31a48b8"
  instance_type               = "t3.nano"
  key_name                    = "mocn-ng"

  subnet_id                   = "subnet-d3d796aa"
  security_groups             = ["sg-9e2db4ee"]
  associate_public_ip_address = true

  tags = {
    Name = "terraform-example"
  }
}
