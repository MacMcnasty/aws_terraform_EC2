provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "WebServer" {
    ami = "ami-02e136e904f3da870"
    availability_zone = "us-east-1a"
    instance_type = "t3.micro"
    subnet_id = "subnet-0b1ca901eaef94d2a"
    vpc_security_groups_ids = [aws_security_group.WebSecurityGroup1.id]
    user_data = <<-EOF
                #!/bin/bash  
                yum update -y
                yum install httpd -y
                echo "<html><body><h1>Hello Everyone</h1></body></html>" >/var/www/html/index.html
                systemctl start httpd
                systemctl enable httpd

    tags = {
        Name = "WebServer1"
        Environment = "Development"
        Backup = "True"
        CostCenter = "1348"
        AppID = "894"
        SupportTeamID = "343"




    }




}
resource "aws_security_group" "WebSecurityGroup1" {
    name = "ExternalAccessWebLayerSecurityGroup"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
}