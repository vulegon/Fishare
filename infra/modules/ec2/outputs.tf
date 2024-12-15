output "nat_instance_id" {
  value = aws_instance.nat_instance.id
}

output "nat_instance_network_interface_id" {
  value = aws_instance.nat_instance.primary_network_interface_id
}
