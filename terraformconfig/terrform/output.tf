output "public_ip"{
  value= aws_instance.http_server.public_ip
}