data "vault_generic_secret" "cf" {
  path = "kv/terraform/cloudflare"
}

resource "cloudflare_dns_record" "dns_record" {
  for_each = var.dns_record
  zone_id = data.vault_generic_secret.cf.data["zone_id"]
  name = each.value.name
  content = each.value.content
  type = each.value.type
  ttl = 60
  proxied = false
}

