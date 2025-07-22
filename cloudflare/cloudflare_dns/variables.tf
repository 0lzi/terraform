variable "cloudflare_email" {
  type        = string
  description = "Clouflare email address"
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare api token"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Zone ID"
  sensitive = true
}

variable "dns_record" {
  type = map(object({
    name    = string
    content   = string
    type = string
  }))
}

