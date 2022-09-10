variable "registered_domain_name" {
  description = "Route 53 Registered Domain Name"
  type        = string
  default     = ""
}

variable "certificate_domain_name" {
  description = "SSL Certificate Domain Name"
  type        = string
  default     = ""
}

variable "hosted_zone_id" {
  description = "Hosted Zone ID"
  type        = string
  default     = ""
}

variable "api_gateway_name" {
  description = "API Gateway Name"
  type        = string
  default     = ""
}

variable "betteruptime_subdomain" {
  description = "Better Uptime Status Page Subdomain"
  type        = string
  default     = ""
}

variable "custom_status_page_subdomain" {
  description = "Custom Status Page Subdomain"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = ""
}
