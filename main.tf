provider "aws" {
  region = var.region
}

module "acm_cert" {
  source = "./module"
  primary_domain            = var.primary_domain
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm
  certificate_name          = var.certificate_name
  tags                      = var.tags
  create_route53_records    = var.create_route53_records
  route53_zone_id           = var.route53_zone_id
  wait_for_validation       = var.wait_for_validation
  validation_record_fqdns   = var.validation_record_fqdns
}
