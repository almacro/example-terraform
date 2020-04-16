#output "public_ip" {
#  description = "Public IP address assigned to the instance"
#  value       = aws_instance.example.*.public_ip
#}
output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "The domain name of the load balancer"
}