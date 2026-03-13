data "aws_ami" "ubuntu" {
    most_recent = true
    owners = [ "099720109477" ]
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" ]
    }

    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }

    filter {
      name = "architecture"
      values = [ "*86_64" ]
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = "my-terra-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2VnXBqVSvxRHr03yIC0ipmSvH+GG+y1xAeML/tbBHgcEGIQVh5UQzAWK/7CaLrB0sVUiD/rksDuebdZiCq/3YfYh01yP8JmlWe1h8fIslyDhEN7xHrV8Jm1r4eS3Ull4y/XlVMM7/SwZwgUdR91S9Ku9A2tsx3SNv+2u6Ky3nXlYG37uze98L8xcOIIfmafqImyELCsyWUryUJyvmli63vawDHXrP2CmVke7+Jf3PFKCPmths6/LvBb2uDm91CDoulp+MBL936uiUt1pRXl0CclxQ5l0OfmuYc6VljoC/i6t2VGfWuIFP/osBHOPk8CxTo3DBFXT84pz3LyB9wgkVnOz0ayfjh8EwQq0OZUIl5hSPrIYYPKaDYRr5TdRqVUHvUOvssB8SBMuNz0PrzaHSg3zxjv46iNLaLxxE8myNgcgapWr387fIfKwQ8uNTuJi9IhhDoZl3xFTrELvOzWVrRVbS/45n3GlhZeireor/oyKtvu9TP9iYQCN8m4bCLvE= batman@DESKTOP-7C3B0GC"
}

resource "aws_instance" "my_terra_instance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    subnet_id = aws_subnet.my_terra_subnet.id
    vpc_security_group_ids = [aws_security_group.my_terra_group.id]
    key_name = aws_key_pair.deployer.key_name
    associate_public_ip_address = true

    tags = {
      Name = "terra_instance"
    }
}