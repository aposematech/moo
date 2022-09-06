terraform {
  # https://www.terraform.io/language/settings/terraform-cloud
  cloud {
    organization = "djfav"
    workspaces {
      name = "cowsay-quotes"
    }
  }

  # https://www.terraform.io/language/providers/requirements
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs
provider "github" {
  # export GITHUB_TOKEN
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = var.aws_region
  # export AWS_ACCESS_KEY_ID
  # export AWS_SECRET_ACCESS_KEY
}

module "git_repo" {
  source               = "./modules/git-repo"
  git_repo_name        = terraform.workspace
  git_repo_description = var.git_repo_description
  # git_repo_homepage_url   = "https://quotes.${var.registered_domain_name}"
  git_repo_homepage_url   = ""
  git_repo_visibility     = var.git_repo_visibility
  aws_access_key_id_name  = "AWS_ACCESS_KEY_ID"
  aws_access_key_id_value = var.aws_access_key_id
  aws_access_key_name     = "AWS_SECRET_ACCESS_KEY"
  aws_access_key_value    = var.aws_access_key
  aws_region_name         = "AWS_REGION"
  aws_region_value        = var.aws_region
}

module "image_repo" {
  source          = "./modules/image-repo"
  image_repo_name = module.git_repo.git_repo_name
}

# module "lambda_function" {
#   source             = "./modules/lambda-function"
#   function_name      = module.image_repo.image_repo_name
#   aws_region         = var.aws_region
#   aws_account_number = var.aws_account_number
# }

module "function_domain" {
  source                 = "./modules/function-domain"
  registered_domain_name = var.registered_domain_name
}
