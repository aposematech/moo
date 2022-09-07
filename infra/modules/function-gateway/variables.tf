variable "lambda_function_name" {
  description = "AWS Lambda Function Name"
  type        = string
  default     = ""
}

variable "lambda_function_arn" {
  description = "AWS Lambda Function ARN"
  type        = string
  default     = ""
}

variable "certificate_domain_name" {
  description = "SSL Certificate Domain Name"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "SSL Certificate ARN"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "aws_account_number" {
  description = "AWS Account Number"
  type        = string
  default     = ""
}
