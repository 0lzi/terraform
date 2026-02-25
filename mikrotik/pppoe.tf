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
  password          = data.vault_generic_secret.routeros.data["pppoe_password"]
  user              = data.vault_generic_secret.routeros.data["pppoe_username"]
}

