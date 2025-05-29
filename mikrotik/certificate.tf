# ===================================
# ROOT CA
# ===================================
resource "routeros_system_certificate" "local-root-ca-cert" {
  name        = "local-root-cert"
  common_name = "local-cert"
  key_size    = "prime256v1"
  key_usage   = ["key-cert-sign", "crl-sign"]
  trusted     = true
  sign {}

  lifecycle {
    ignore_changes = [
      sign
    ]
  }
}

# ===================================
# CERTIFICATES
# ===================================
resource "routeros_system_certificate" "webfig_1" {
  name        = "Webfig"
  common_name = "Mikrotik"
  subject_alt_name = "DNS:mikrotik.0lzi.internal,IP:10.18.10.1"
  country      = "GB"
  organization = "0lzi.com"
  unit         = "HOME"
  days_valid   = 3650

  key_usage = ["key-cert-sign", "crl-sign", "digital-signature", "key-agreement", "tls-server"]
  key_size  = "prime256v1"

  trusted = true
  sign {
    ca = routeros_system_certificate.local-root-ca-cert.name
  }

  lifecycle {
    ignore_changes = [
      sign
    ]
  }
}

