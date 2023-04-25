data "cloudflare_zone" "this" {
  name = var.cloudflare_zone_name
}

resource "cloudflare_record" "dns_record" {
  zone_id = data.cloudflare_zone.this.id

  dynamic "record" {
    for_each = var.dns_record

    content  {
      name = record.value["name"]
      value = record.value["value"]
      type = "A"
      ttl = 60
      proxied = false
    }
  }
}