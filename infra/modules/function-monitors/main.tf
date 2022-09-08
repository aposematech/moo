terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.0"
    }
    checkly = {
      source  = "checkly/checkly"
      version = "~> 1.4.0"
    }
  }
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_monitor
resource "betteruptime_monitor" "monitor" {
  monitor_type = "status"
  url          = "https://${var.certificate_domain_name}/${var.api_gateway_name}"
  email        = true
  paused       = true

  check_frequency     = 180
  request_timeout     = 15
  confirmation_period = 3
  regions             = ["us", "eu", "as", "au"]

  domain_expiration = 30
  verify_ssl        = true
  ssl_expiration    = 30
}

# out of free status pages

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_status_page
# resource "betteruptime_status_page" "status_page" {
#   company_name  = var.certificate_domain_name
#   company_url   = "https://${var.certificate_domain_name}/${var.api_gateway_name}"
#   subdomain     = var.betteruptime_subdomain
#   custom_domain = "${var.custom_status_page_subdomain}.${var.registered_domain_name}"
#   timezone      = "Central Time (US & Canada)"
# }

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_status_page_resource
# resource "betteruptime_status_page_resource" "status_page_resource" {
#   public_name    = "${var.certificate_domain_name}/${var.api_gateway_name}"
#   resource_id    = betteruptime_monitor.monitor.id
#   resource_type  = "Monitor"
#   status_page_id = betteruptime_status_page.status_page.id
#   history        = true
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
# resource "aws_route53_record" "status_page_record" {
#   zone_id = var.hosted_zone_id
#   name    = var.custom_status_page_subdomain
#   type    = "CNAME"
#   records = ["statuspage.betteruptime.com"]
#   ttl     = 60
# }

# https://registry.terraform.io/providers/checkly/checkly/latest/docs/resources/check
resource "checkly_check" "api_check" {
  name                      = "${var.certificate_domain_name}/${var.api_gateway_name}"
  type                      = "API"
  activated                 = false
  should_fail               = false
  frequency                 = 15
  double_check              = true
  use_global_alert_settings = true

  locations = [
    var.aws_region
  ]

  request {
    url      = "https://${var.certificate_domain_name}/${var.api_gateway_name}"
    skip_ssl = false
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
  }
}
