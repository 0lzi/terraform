resource "routeros_ip_firewall_addr_list" "rfc1918" {
   for_each = {
    "1"       = { address = "192.168.0.0/16" , list = "RFC1918" }
    "2"       = { address = "10.0.0.0/8" , list = "RFC1918" }
    "3"       = { address = "172.16.0.0/12" , list = "RFC1918" }
  }
  address = each.value.address
  list    = each.value.list
  comment = each.value.list
}

resource "routeros_ip_firewall_addr_list" "wan" {
  address = var.wan_address
  list    = "WAN"
  comment = "WAN"
}
