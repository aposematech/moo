# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api
resource "aws_apigatewayv2_api" "api" {
  name                         = var.api_gateway_name
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true

  cors_configuration {
    allow_credentials = false
    allow_headers     = []
    allow_methods     = []
    allow_origins     = ["*"]
    expose_headers    = []
    max_age           = 0
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "default"
  description = "Managed by Terraform"
  auto_deploy = true

  default_route_settings {
    throttling_burst_limit = 1
    throttling_rate_limit  = 1
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_function_arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route
resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /${aws_apigatewayv2_api.api.name}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_domain_name
resource "aws_apigatewayv2_domain_name" "api_domain_name" {
  domain_name = var.certificate_domain_name

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api_mapping
resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.api.id
  domain_name = var.certificate_domain_name
  stage       = aws_apigatewayv2_stage.default_stage.id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "api_gateway_record" {
  zone_id = var.hosted_zone_id
  name    = var.certificate_domain_name
  type    = "A"

  alias {
    name                   = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration.0.target_domain_name
    zone_id                = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration.0.hosted_zone_id
    evaluate_target_health = false
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "allow-${aws_apigatewayv2_api.api.name}-api-gateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_apigatewayv2_api.api.name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_number}:${aws_apigatewayv2_api.api.id}/*/*/${aws_apigatewayv2_api.api.name}"
}
