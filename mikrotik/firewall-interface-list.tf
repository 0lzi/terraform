# ========================================
# WAN Interface
# ========================================
resource "routeros_interface_list" "wan" {
  name = "WAN"
}

resource "routeros_interface_list_member" "wan_ether7" {
  interface = "ether7"
  list      = routeros_interface_list.wan.name
}
resource "routeros_interface_list_member" "pppoe-out1" {
  interface = "pppoe-out1"
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
  name = "MGMT"
}

resource "routeros_interface_list_member" "mgmt" {
  interface = "vlan10"
  list      = routeros_interface_list.mgmt.name
}
# ========================================
# Wireguard interface
# ========================================
resource "routeros_interface_list" "wg1" {
  name = "WG1"
}

resource "routeros_interface_list_member" "wg1" {
  interface = "wireguard1"
  list      = routeros_interface_list.wg1.name
}
