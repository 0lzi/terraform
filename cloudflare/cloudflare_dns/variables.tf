variable "cloudflare_email" {
  type        = string
  description = "clouflare email address"
}

variable "cloudflare_api_token" {
  type        = string
  description = "cloudflare api token"
}

variable "cloudflare_zone_name" {
  type        = string
  description = "domain.com"
}

variable "records" {
  type = map(object({
    name    = string
    value   = string
  }))
}
