
data "aws_subnet" "existing" {
  filter {
    name   = "tag:Name"
    values = ["sai-public-subnet"]
  }
  vpc_id = var.vpc_id
}

data "aws_security_group" "existing_sg" {
  filter {
    name   = "tag:name"
    values = ["sai-web_sg"]
  }
  vpc_id = var.vpc_id
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.existing.id
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  key_name      = var.key_name
  user_data = templatefile("${path.module}/templates/web_user_data.sh", {
    web_app_content = templatefile("${path.module}/templates/web_app.py", {
      app_private_ip = "localhost"
    })
    web_service_content = file("${path.module}/templates/web.service")
  })

  tags = {
    Name = "sai-app-instance"
  }
}