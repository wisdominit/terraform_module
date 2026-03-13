variable "ingress_rules" {
  type = list(object({
    from = number
    to   = number
    proto = string
    cidr = string
  }))

  default = [ {
    from = 22
    to = 22
    proto = "tcp"
    cidr = "0.0.0.0/0"
  },
  {
    from = 80
    to = 80
    proto = "tcp"
    cidr = "0.0.0.0/0"
  },
  {
    from = 443
    to = 443
    proto = "tcp"
    cidr = "0.0.0.0/0"
  }
  ]
}

resource "aws_security_group" "my_terra_group" {
  name = "terraform sg group"
  description = "test terraform sg group"
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "terra_sg_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "terra_ingress_rule" {
  for_each = { for id, rule in var.ingress_rules : id => rule }
  security_group_id = aws_security_group.my_terra_group.id

  from_port = each.value.from
  to_port = each.value.to
  ip_protocol = each.value.proto
  cidr_ipv4 = var.my_ip
}

resource "aws_vpc_security_group_egress_rule" "terra_egress_rule" {
  security_group_id = aws_security_group.my_terra_group.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
