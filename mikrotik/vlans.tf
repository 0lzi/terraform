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
