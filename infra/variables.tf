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
