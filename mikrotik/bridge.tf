# ==================================================================
# Bridge and bridge_port setup
# ==================================================================
resource "routeros_interface_bridge" "bridge" {
  name           = "bridge1"
  admin_mac      = "E6:60:B9:7E:E3:56"
  vlan_filtering = true
  auto_mac       = false
  pvid           = "1"
}

resource "routeros_interface_bridge_port" "bridge_ports" {
  for_each = {
    "ether1"       = { comment = "defconf", pvid = "1" }
    "ether2"       = { comment = "defconf", pvid = "1" }
    "ether3"       = { comment = "defconf", pvid = "1" }
    "ether4"       = { comment = "defconf", pvid = "10" }
    "ether5"       = { comment = "defconf", pvid = "1" }
    "ether6"       = { comment = "defconf", pvid = "1" }
    "ether8"       = { comment = "defconf", pvid = "10" }
    "sfp-sfpplus1" = { comment = "defconf", pvid = "1" }
    "sfp-sfpplus2" = { comment = "defconf", pvid = "1" }
  }
  bridge    = "bridge"
  interface = each.key
  comment   = each.value.comment
  pvid      = each.value.pvid
}

