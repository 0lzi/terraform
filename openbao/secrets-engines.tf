resource "vault_mount" "kv-v2" {
  path        = "kv"
  type        = "kv"
  description = "KV v2 Secrets engine"
  options = {
    version = "2"
    type    = "kv-v2"
  }
}

# ===================================
# PKI
# ===================================
locals {
  thirty_day_in_sec = 2592000
  one_yr_in_sec     = 31536000
  five_yr_in_sec    = 157680000
  ten_yr_in_sec     = 315360000
}

resource "vault_mount" "pki" {
  path        = "pki"
  type        = "pki"
  description = "ROOT CA PKI mount"

  default_lease_ttl_seconds = local.thirty_day_in_sec
  max_lease_ttl_seconds     = local.ten_yr_in_sec
}

# ===================================
# ROOT CA
# ===================================

resource "vault_pki_secret_backend_root_cert" "root_ca" {
  backend     = vault_mount.pki.path
  type        = "internal"
  common_name = "0lzi.internal"
  ttl         = local.ten_yr_in_sec
  issuer_name = "0lzi-ROOT-CA"
}

output "vault_pki_secret_backend_root_cert" {
  value = vault_pki_secret_backend_root_cert.root_ca.certificate
}
# # Not needed
# resource "local_file" "root_ca_cert" {
#   content  = vault_pki_secret_backend_root_cert.root_ca.certificate
#   filename = "root_ca.crt"
# }

resource "vault_pki_secret_backend_issuer" "root_ca" {
  backend                        = vault_mount.pki.path
  issuer_ref                     = vault_pki_secret_backend_root_cert.root_ca.issuer_id
  issuer_name                    = vault_pki_secret_backend_root_cert.root_ca.issuer_name
  revocation_signature_algorithm = "SHA256WithRSA"
}

resource "vault_pki_secret_backend_role" "role" {
  backend          = vault_mount.pki.path
  name             = "servers-role"
  allow_ip_sans    = true
  ttl              = local.thirty_day_in_sec
  allowed_domains  = ["0lzi.internal"]
  key_type         = "rsa"
  key_bits         = 4096
  allow_subdomains = true
  allow_any_name   = true
}

resource "vault_pki_secret_backend_config_urls" "config-urls" {
  backend                 = vault_mount.pki.path
  issuing_certificates    = ["https://vault.0lzi.com/v1/pki/ca"]
  crl_distribution_points = ["https://vault.0lzi.com/v1/pki/crl"]
}

# ===================================
# INT CA
# ===================================

resource "vault_mount" "pki_int" {
  path        = "pki_int"
  type        = "pki"
  description = "Intermediate PKI mount"

  default_lease_ttl_seconds = local.one_yr_in_sec
  max_lease_ttl_seconds     = local.five_yr_in_sec
}

resource "vault_pki_secret_backend_intermediate_cert_request" "csr-request" {
  backend     = vault_mount.pki_int.path
  type        = "internal"
  common_name = "0lzi.internal Intermediate Authority"
}

# Not needed after Int CA CSR has been signed
# resource "local_file" "csr_request_cert" {
#   content  = vault_pki_secret_backend_intermediate_cert_request.csr-request.csr
#   filename = "pki_intermediate.csr"
# }

resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
  backend     = vault_mount.pki.path
  common_name = "intermediate"
  csr         = vault_pki_secret_backend_intermediate_cert_request.csr-request.csr
  format      = "pem_bundle"
  ttl         = local.five_yr_in_sec
  issuer_ref  = vault_pki_secret_backend_root_cert.root_ca.issuer_id
}
# Not needed, can be read from bao read -format=json pki_int/cert/ca
# resource "local_file" "intermediate_ca_cert" {
#   content  = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
#   filename = "intermediate.cert.pem"
# }

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  backend     = vault_mount.pki_int.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
}

resource "vault_pki_secret_backend_issuer" "intermediate" {
  backend     = vault_mount.pki_int.path
  issuer_ref  = vault_pki_secret_backend_intermediate_set_signed.intermediate.imported_issuers[0]
  issuer_name = "0lzi-internal-intermediate"
}

# ========================================
# ROLES
# ========================================

resource "vault_pki_secret_backend_role" "intermediate_role" {
  backend          = vault_mount.pki_int.path
  issuer_ref       = vault_pki_secret_backend_issuer.intermediate.issuer_ref
  name             = "0lzi-dot-internal-com"
  ttl              = local.thirty_day_in_sec
  max_ttl          = local.one_yr_in_sec
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = ["0lzi.internal", "0lzi.com"]
  allow_subdomains = true

}
