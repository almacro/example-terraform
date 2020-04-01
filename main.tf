resource "aws_instance" "example" {
  ami           = "ami-014a2e30da708ee8b"
  instance_type = "t3.nano"

  tags = {
    Name = "terraform-example"
  }
}
