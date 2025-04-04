variable "primary_domain" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of subject alternative names (SANs) for the certificate"
  type        = list(string)
  default     = []
}

variable "validation_method" {
  description = "Validation method for the certificate (DNS or EMAIL)"
  type        = string
  default     = "DNS"
  validation {
    condition     = contains(["DNS", "EMAIL"], var.validation_method)
    error_message = "Validation method must be either DNS or EMAIL."
  }
}

variable "certificate_name" {
  description = "Name tag for the certificate"
  type        = string
  default     = ""
}

variable "key_algorithm" {
  description = "Algorithm for the certificate's key"
  type        = string
  default     = "RSA_2048"
  validation {
    condition     = contains(["RSA_2048", "EC_prime256v1", "EC_secp384r1"], var.key_algorithm)
    error_message = "Key algorithm must be one of RSA_2048, EC_prime256v1, or EC_secp384r1."
  }
}

variable "create_route53_records" {
  description = "Whether to create Route53 records for DNS validation"
  type        = bool
  default     = true
}

variable "route53_zone_id" {
  description = "Route53 zone ID for DNS validation records"
  type        = string
  default     = ""
}

variable "validation_record_fqdns" {
  description = "List of FQDNs for validation records when not managing Route53"
  type        = list(string)
  default     = []
}

variable "wait_for_validation" {
  description = "Whether to wait for certificate validation to complete"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags for the certificate"
  type        = map(string)
  default     = {}
}
