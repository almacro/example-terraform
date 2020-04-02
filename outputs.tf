output "public_ip" {
  description = "Public IP address assigned to the instance"
  value = aws_instance.example.*.public_ip
}