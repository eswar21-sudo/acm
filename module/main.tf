resource "aws_acm_certificate" "cert" {
  domain_name               = var.primary_domain
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    {
      Name = var.certificate_name != "" ? var.certificate_name : var.primary_domain
    },
    var.tags
  )
}

# DNS Validation - Route53
resource "aws_route53_record" "validation" {
  count = var.validation_method == "DNS" && var.create_route53_records ? length(aws_acm_certificate.cert.domain_validation_options) : 0

  zone_id = var.route53_zone_id
  name    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_type
  records = [aws_acm_certificate.cert.domain_validation_options[count.index].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  count = var.validation_method == "DNS" && var.wait_for_validation ? 1 : 0

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = var.create_route53_records ? aws_route53_record.validation[*].fqdn : var.validation_record_fqdns
}
