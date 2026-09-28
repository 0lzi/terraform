resource "routeros_ip_dhcp_server_lease" "instance" {
  for_each = var.dhcp_leases

  address     = each.value.address
  mac_address = each.value.mac_address
  server      = each.value.server
}

resource "routeros_ip_dns_record" "instance" {
  for_each = var.dhcp_leases

  name    = "${each.key}.${each.value.dns_domain}"
  address = routeros_ip_dhcp_server_lease.instance[each.key].address
  type    = "A"
}
