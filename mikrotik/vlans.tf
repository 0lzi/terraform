# ==================================================================
# VLAN interfaces
# ==================================================================
resource "routeros_interface_vlan" "interface_vlan" {
   for_each = {
    "vlan10"       = { comment = "MGMT"  , vlan_id = 10  , interface = "bridge" }
    "vlan20"       = { comment = "PROD"  , vlan_id = 20  , interface = "bridge" }
    "vlan30"       = { comment = "DEV"   , vlan_id = 30  , interface = "bridge" }
    "vlan40"       = { comment = "IoT"   , vlan_id = 40  , interface = "bridge" }
    "vlan50"       = { comment = "HOME"  , vlan_id = 50  , interface = "bridge" }
    "vlan100"      = { comment = "Guest" , vlan_id = 100 , interface = "bridge" }
   }
  name      = each.key
  interface = each.value.interface
  comment   = each.value.comment
  vlan_id   = each.value.vlan_id
}

# ==================================================================
# Bridge VLANs
# ==================================================================
resource "routeros_interface_bridge_vlan" "mgmt_vlan" {
  comment = "MGMT"
  bridge   = "bridge"
  vlan_ids = ["10"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}

resource "routeros_interface_bridge_vlan" "prod_vlan" {
  comment = "PROD"
  bridge   = "bridge"
  vlan_ids = ["20"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}

resource "routeros_interface_bridge_vlan" "dev_vlan" {
  comment = "DEV"
  bridge   = "bridge"
  vlan_ids = ["30"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}

resource "routeros_interface_bridge_vlan" "iot_vlan" {
  comment = "IoT"
  bridge   = "bridge"
  vlan_ids = ["40"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}

resource "routeros_interface_bridge_vlan" "home_vlan" {
  comment = "HOME"
  bridge   = "bridge"
  vlan_ids = ["50"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}

resource "routeros_interface_bridge_vlan" "guest_vlan" {
  comment = "Guest"
  bridge   = "bridge"
  vlan_ids = ["100"]
  tagged = [
    "bridge",
    "ether1",
    "ether2",
    "ether3",
    "ether5",
    "ether6"
  ]
}
