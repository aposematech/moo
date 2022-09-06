# https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html#urls-auth-none
terraform {
  # https://www.terraform.io/language/providers/requirements
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.28.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_role_permissions_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${var.aws_account_number}:log-group:/aws/lambda/${var.function_name}:*",
    ]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "lambda_role_permissions" {
  name   = "${var.function_name}-lambda-role-permissions"
  policy = data.aws_iam_policy_document.lambda_role_permissions_policy_document.json
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "lambda_role" {
  name               = "${var.function_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json
  managed_policy_arns = [
    aws_iam_policy.lambda_role_permissions.arn,
  ]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "lambda_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_role_permissions.arn
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  package_type  = "Image"
  image_uri     = "${var.aws_account_number}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.function_name}:latest"
  role          = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      EXAMPLE_ENV_VAR = "example"
    }
  }
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = aws_lambda_function.lambda_function.function_name
  authorization_type = "NONE"

  cors {
    allow_origins = ["*"]
    allow_methods = ["GET", "HEAD"]
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
resource "aws_acm_certificate" "certificate" {
  domain_name       = "quotes.${var.registered_domain_name}"
  validation_method = "DNS"

  validation_option {
    domain_name       = "quotes.${var.registered_domain_name}"
    validation_domain = var.registered_domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
resource "aws_route53_record" "certificate_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation
resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate_validation_record : record.fqdn]
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = "quotes.${var.registered_domain_name}"
    origin_id   = aws_lambda_function_url.function_url.function_url
  }

  enabled = true
  aliases = ["${var.registered_domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.registered_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
# resource "aws_route53_record" "cloudfront_distribution_record" {
#   zone_id = aws_route53_zone.zone.zone_id
#   name    = var.registered_domain_name
#   type    = "A"

#   alias {
#     name                   = aws_cloudfront_distribution.cloudfront_distribution.domain_name
#     zone_id                = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
#     evaluate_target_health = false
#   }
# }
