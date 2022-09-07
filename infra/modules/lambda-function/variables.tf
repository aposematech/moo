variable "function_name" {
  description = "Lambda Function Name"
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

variable "api_arn" {
  description = "API Gateway ARN"
  type        = string
  default     = ""
}
