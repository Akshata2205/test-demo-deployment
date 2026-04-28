resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "http_server_sg" {
  name= "http_server_sg"
  vpc_id= aws_default_vpc.default.id
  ingress{
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress{
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }
  ingress{
    from_port=0
    to_port=0
    protocol=-1
    cidr_blocks=["0.0.0.0/0"]
  }
}

resource "aws_instance" "http_server"{
  ami = data.aws_ami.aws_linux_latest.id
  key_name="default-key-pair"
  instance_type="t3.micro"
  vpc_security_group_ids=[aws_security_group.http_server_sg.id]
  subnet_id= data.aws_subnets.default_subnets.ids[0]
}
