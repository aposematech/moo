variable "api_gateway_name" {
  description = "API Gateway Name"
  type        = string
}

variable "lambda_function_arn" {
  description = "AWS Lambda Function ARN"
  type        = string
}

variable "certificate_domain_name" {
  description = "SSL Certificate Domain Name"
  type        = string
}

variable "certificate_arn" {
  description = "SSL Certificate ARN"
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
}
