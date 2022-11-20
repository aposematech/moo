variable "registered_domain_name" {
  description = "Route 53 Registered Domain Name"
  type        = string
}

variable "certificate_domain_name" {
  description = "SSL Certificate Domain Name"
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
}

variable "api_gateway_name" {
  description = "API Gateway Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}
