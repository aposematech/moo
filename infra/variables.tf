variable "git_repo_description" {
  description = "GitHub Repo Description"
  type        = string
  default     = ""
}

variable "git_repo_visibility" {
  description = "GitHub Repo Visibility"
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

variable "aws_access_key_id" {
  description = "AWS Access Key ID - GitHub Actions Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "aws_access_key" {
  description = "AWS Access Key - GitHub Actions Secret"
  type        = string
  default     = ""
  sensitive   = true
}

variable "registered_domain_name" {
  description = "Route 53 Registered Domain Name"
  type        = string
  default     = ""
}

variable "api_subdomain_name" {
  description = "API Subdomain Name"
  type        = string
  default     = ""
}

variable "betteruptime_api_token" {
  description = "Better Uptime API Token"
  type        = string
  default     = ""
  sensitive   = true
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

variable "checkly_account_id" {
  description = "Checkly Account ID"
  type        = string
  default     = ""
}

variable "checkly_api_key" {
  description = "Checkly API Key"
  type        = string
  default     = ""
  sensitive   = true
}
