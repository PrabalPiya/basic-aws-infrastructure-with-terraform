output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web_server.id
}

output "public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "website_url" {
  description = "URL to open in browser"
  value       = "http://${aws_instance.web_server.public_ip}"
}