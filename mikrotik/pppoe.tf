# ===========================================
# PPPOE Client for Internet
# ===========================================
resource "routeros_interface_pppoe_client" "pnet" {
  interface         = "ether7"
  name              = "pppoe-out1"
  comment           = "PlusNet"
  add_default_route = true
  use_peer_dns      = false
  dial_on_demand    = true
  profile           = "default-encryption"
  password          = var.pppoe_password
  user              = var.pppoe_username
}

