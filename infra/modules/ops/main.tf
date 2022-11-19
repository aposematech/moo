terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
    betteruptime = {
      source  = "BetterStackHQ/better-uptime"
      version = "~> 0.3.12"
    }
    checkly = {
      source  = "checkly/checkly"
      version = "~> 1.4.3"
    }
  }
}

# https://registry.terraform.io/providers/BetterStackHQ/better-uptime/latest/docs/resources/betteruptime_monitor
resource "betteruptime_monitor" "monitor" {
  monitor_type = "status"
  url          = "https://${var.certificate_domain_name}/${var.api_gateway_name}"
  email        = true
  paused       = false

  check_frequency     = 180
  request_timeout     = 15
  confirmation_period = 3
  regions             = ["us", "eu", "as", "au"]

  domain_expiration = 30
  verify_ssl        = true
  ssl_expiration    = 30
}

# https://registry.terraform.io/providers/checkly/checkly/latest/docs/resources/check
resource "checkly_check" "api_check" {
  name                      = "${var.certificate_domain_name}/${var.api_gateway_name}"
  type                      = "API"
  activated                 = true
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
