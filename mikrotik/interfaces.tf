# =====================================
# Wireguard Port Setup
# =====================================
resource "routeros_interface_wireguard" "wg0" {
  name        = "wg0"
  listen_port = "13231"
  comment     = "Wireguard"
  private_key = data.vault_generic_secret.routeros.data["wg_priv_key"]
}

# =====================================
# Peer
# =====================================
resource "routeros_interface_wireguard_peer" "wg_peer" {
  interface      = routeros_interface_wireguard.wg0.name
  name           = "Phone"
  public_key     = data.vault_generic_secret.routeros.data["wg_phone_pub"]
  private_key    = data.vault_generic_secret.routeros.data["wg_phone_priv"]
  client_address = "10.10.0.2/30"
  client_dns     = "10.18.10.1"
  allowed_address = [
    "0.0.0.0/0",
  ]
}
# =====================================
# Switch Port Setup
# =====================================

resource "routeros_interface_ethernet" "ethernet" {
  for_each = {
    "ether1"       = { comment = "pve1-trunk" }
    "ether2"       = { comment = "pve2-trunk" }
    "ether3"       = { comment = "pve3-trunk" }
    "ether4"       = { comment = "N/A" }
    "ether5"       = { comment = "WAP" }
    "ether6"       = { comment = "Cisco16P" }
    "ether7"       = { comment = "Uplink trunk" }
    "ether8"       = { comment = "Desktop2_5G" }
    "sfp-sfpplus1" = { comment = "Desktop10G" }
    "sfp-sfpplus2" = { comment = "N/A" }
  }
  name         = each.key
  factory_name = each.key
  comment      = each.value.comment
}
