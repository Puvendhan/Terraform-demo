provider "aws" {
  region = "${var.region}"
  version = "~> 2.0"
}

resource "aws_vpc" "testvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "testvpc"
  }
}

resource "aws_subnet" "testsubnets" {
  count      =  "${length(var.azs)}"
  vpc_id     = "${aws_vpc.testvpc.id}"
  cidr_block = "${element(var.subnet_cidr,count.index)}"

  tags = {
    Name = "testsubnet-${count.index+1}"
  }
}

resource "aws_security_group" "lambda-security-group" {
  #count = "${var.count_number}"
  name_prefix = "${var.environment}-${var.lambda_function_name}"
  vpc_id = "${var.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.environment}-${var.lambda_function_name}"
    Environment = "${var.environment}"
    Contact = "${var.contact_information}"
  }
}

resource "aws_security_group_rule" "lambda-ingress-all-tcp" {
  #count = "${var.count_number}"
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "TCP"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.lambda-security-group.id}"
}

resource "aws_security_group_rule" "lambda-egress-all-tcp" {
  #count = "${var.count_number}"
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "TCP"

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.lambda-security-group.id}"
}
