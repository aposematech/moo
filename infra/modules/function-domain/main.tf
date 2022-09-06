terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53domains_registered_domain
resource "aws_route53domains_registered_domain" "registered_domain" {
  domain_name = var.registered_domain_name
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
resource "aws_route53_zone" "zone" {
  name = var.registered_domain_name
}
