terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.16.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.15"
    }
    checkly = {
      source  = "checkly/checkly"
      version = "~> 1.6.3"
    }
  }

  required_version = "~> 1.3.7"
}
