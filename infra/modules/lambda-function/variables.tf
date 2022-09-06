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

variable "registered_domain_name" {
  description = "Route 53 Registered Domain Name"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
  default     = ""
}
