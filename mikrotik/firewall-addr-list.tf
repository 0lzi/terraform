# ==================================================================
# Firewall Address List RFC1918
# ==================================================================

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

# ==================================================================
# Firewall Address List WAN
# ==================================================================

resource "routeros_ip_firewall_addr_list" "wan" {
  address = var.wan_address
  list    = "WAN"
  comment = "WAN"
}

# ==================================================================
# Firewall Address List LAN
# ==================================================================

resource "routeros_ip_firewall_addr_list" "lan" {
   for_each = {
    "vlan10"       = { address = routeros_ip_dhcp_server_network.mgmt.address , list = "MGMT" }
    "vlan20"       = { address = routeros_ip_dhcp_server_network.prod.address , list = "PROD" }
    "vlan30"       = { address = routeros_ip_dhcp_server_network.dev.address  , list = "DEV" }
    "vlan40"       = { address = routeros_ip_dhcp_server_network.iot.address  , list = "IOT" }
    "vlan50"       = { address = routeros_ip_dhcp_server_network.home.address , list = "HOME" }
    "vlan100"      = { address = routeros_ip_dhcp_server_network.guest.address, list = "GUEST" }
  }
  address = each.value.address
  list    = each.value.list
  comment = each.value.list
}
