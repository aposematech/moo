output "hosted_zone_id" {
  value       = aws_route53_zone.zone.zone_id
  description = "Route 53 Hosted Zone ID"
}

output "certificate_domain_name" {
  value       = aws_acm_certificate.certificate.domain_name
  description = "SSL Certificate Domain Name"
}

output "certificate_arn" {
  value       = aws_acm_certificate.certificate.arn
  description = "SSL Certificate ARN"
}
