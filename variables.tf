variable "my_cidr_block" {
    description = "my vpc cidr range"
}

variable "my_subnet" {
    description = "my subnet range"
}

variable "default_route" {
    description = "default route"
}

variable "my_ip" {
    description = "my ipaddress"
    default = "0.0.0.0/0"
}

variable "instance_type" {
    description = "ec2 instance type"
    default = "t2.micro"
}