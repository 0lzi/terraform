# =====================================
# Switch Port Setup
# =====================================

# resource "routeros_interface_ethernet_switch_port" "ethernet" {
#   for_each = {
#     "ether1"       = { switch = "switch1", hw_offload = false }
#     "ether2"       = { switch = "switch1", hw_offload = false }
#     "ether3"       = { switch = "switch1", hw_offload = false }
#     "ether4"       = { switch = "switch1", hw_offload = false }
#     "ether5"       = { switch = "switch1", hw_offload = false }
#     "ether6"       = { switch = "switch1", hw_offload = false }
#     "ether8"       = { switch = "switch1", hw_offload = false }
#     "sfp-sfpplus1" = { switch = "switch1", hw_offload = false }
#     "sfp-sfpplus2" = { switch = "switch1", hw_offload = false }
#   }
#   name = each.key
#   switch = each.value.switch
#   l3_hw_offloading = each.value.hw_offload
# }
