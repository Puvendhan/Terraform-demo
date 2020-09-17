variable "region" {
  default = "ap-south-1"

}

variable "environment" {
  description = "Name of the environment (e.g. dev); will be prefixed to all resources"
  type = "string"
}

variable "contact_information" {
  type = "string"
  description = "The contact information for a resource"
}

variable "lambda_function_name" {
  type = "string"
  description = "Lambda function name with out environment prefix"
}

variable "count_number" {
  type = "string"
  description = "Enable or disable resources (0 or 1)"
  default = "1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"

}

variable "subnet_cidr" {
  type    = "list"
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]

}

variable "azs" {
  type    = "list"
  default = ["ap-south-1a","ap-south-1b","ap-south-1c"]

}

#variable "private_subnet_ids" {
#  type  = "string"
#  description = "The subnet in which the service will run"
#}

variable "vpc_id" {
  type = "string"
  description = "The VPC to where the service will run"
}

#variable "default_environment_sg_id" {
#  type = "string"
#  description = "Id if the default environment security group"
#}

