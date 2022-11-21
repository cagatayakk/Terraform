output "url" {
  value = try(aws_lb.my_elb.dns_name, "")
}