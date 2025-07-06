#key pair
resource "aws_key_pair" "deployer" {
  key_name = "${var.env}-infra-app-key-new"
  public_key = file("C:/Snehal-Pratical/terraform-practice-2/terra-ec2-key.pub")
  
  tags = {
    Environment = var.env
  }
}

#vpc - for security groups
resource "aws_default_vpc" "default_vpc" {
  
}

#security group
resource "aws_security_group" "my_security_group" {
  name = "${var.env}infra-app-sg"
  description = "This is my security group"
  vpc_id = aws_default_vpc.default_vpc.id #interpolation= inherit value from terraform block

 #ingress = inbound rule
 ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow 22 port"
  }

   ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow 80 port"
  }

 ingress {
    protocol  = "tcp"
    self      = true
    from_port = 8000
    to_port   = 8000
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow 8000 port"
  }

 #outbound = egress
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all traffic"
  }

  tags = {
    name="${var.env}-allow_port"
    Environment = var.env
  }

}

#ec2 instance
resource "aws_instance" "aws_instance_ec2" {
  count = var.instance_count

  depends_on = [ aws_security_group.my_security_group ] 

  key_name = aws_key_pair.deployer.key_name
  security_groups = [ aws_security_group.my_security_group.name ]
  instance_type = var.instance_type
  ami = var.image_id
  user_data = file("C:/Snehal-Pratical/terraform-practice-2/shell.sh") #This is use to run file when we create instance for first time
  root_block_device {
    volume_size = var.env == "prod" ? 8 : 8 #conditional operation
    volume_type = "gp3"
  }
  tags = {
    Name = "${var.env}-infra-app-instance"
    Environment = var.env
  }

}

#Import ec2 instance created on AWS GUI
#terraform import aws_instance.my_new_instance <instance-id>(copy it from AWS)
# resource "aws_instance" "my_new_instance" {
# }