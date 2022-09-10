variable "function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "db_table_arn" {
  description = "DynamoDB Table ARN"
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
