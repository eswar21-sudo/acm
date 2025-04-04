output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "certificate_domain_validation_options" {
  description = "Domain validation options for the certificate"
  value       = aws_acm_certificate.cert.domain_validation_options
}

output "validation_records" {
  description = "Validation records created in Route53"
  value       = aws_route53_record.validation
}

output "certificate_status" {
  description = "Status of the certificate"
  value       = aws_acm_certificate.cert.status
}
