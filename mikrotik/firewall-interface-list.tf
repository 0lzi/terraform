# ========================================
# WAN Interface
# ========================================
resource "routeros_interface_list" "wan" {
  name = "WAN"
}

resource "routeros_interface_list_member" "wan_ether7" {
  interface = "vlan4000"
  comment   = "WAN Interface"
  list      = routeros_interface_list.wan.name
}
resource "routeros_interface_list_member" "pppoe-out1" {
  interface = "pppoe-out1"
  comment   = "WAN Interface"
  list      = routeros_interface_list.wan.name
}

# ========================================
# LAN Interface
# ========================================
resource "routeros_interface_list" "lan" {
  name = "LAN"
}

resource "routeros_interface_list_member" "interface" {
  for_each = {
    "bridge"       = {}
    "ether1"       = {}
    "ether2"       = {}
    "ether3"       = {}
    "ether4"       = {}
    "ether5"       = {}
    "ether6"       = {}
    "ether7"       = {}
    "ether8"       = {}
    "sfp-sfpplus1" = {}
    "sfp-sfpplus2" = {}
  }
  interface = each.key
  comment   = routeros_interface_list.lan.name
  list      = routeros_interface_list.lan.name
}
# ========================================
# MGMT interface
# ========================================
resource "routeros_interface_list" "mgmt" {
  name    = "MGMT"
  comment = "MGMT"
}

resource "routeros_interface_list_member" "mgmt" {
  interface = "vlan10"
  comment   = "MGMT"
  list      = routeros_interface_list.mgmt.name
}
# ========================================
# Wireguard interface
# ========================================
resource "routeros_interface_list" "wg0" {
  name = "WG0"
}

resource "routeros_interface_list_member" "wg0" {
  interface = "wg0"
  comment   = "WG0"
  list      = routeros_interface_list.wg0.name
}
