# ==================================================================
# Firewall INPUT Filter Rules
# ensure place_before = "" is included for firewall rule order
# ==================================================================
resource "routeros_ip_firewall_filter" "allow_rfc1918" {
  action           = "accept"
  disabled         = false
  chain            = "input"
  comment          = "Allow from rfc1918 addresses"
  src_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.allow_wg.id
}

resource "routeros_ip_firewall_filter" "allow_wg" {
  action           = "accept"
  disabled         = false
  chain            = "input"
  comment          = "Allow Wireguard"
  protocol         = "udp"
  dst_port         = 13231
  dst_address_list = "WAN"
  place_before     = routeros_ip_firewall_filter.accept_established_related_untracked.id
}

resource "routeros_ip_firewall_filter" "accept_established_related_untracked" {
  action           = "accept"
  disabled         = false
  chain            = "input"
  comment          = "Allow established-related"
  connection_state = "established,related"
  place_before     = routeros_ip_firewall_filter.drop_invalid.id
}

resource "routeros_ip_firewall_filter" "drop_invalid" {
  action           = "drop"
  disabled         = false
  chain            = "input"
  comment          = "Drop Invalid"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.drop_icmp.id
}

resource "routeros_ip_firewall_filter" "drop_icmp" {
  action       = "drop"
  disabled         = false
  chain        = "input"
  comment      = "Drop ICMP from WAN"
  in_interface = "pppoe-out1"
  protocol     = "icmp"
  place_before = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "default_drop" {
  action       = "drop"
  disabled         = false
  chain        = "input"
  comment      = "Default-Drop"
  in_interface = "pppoe-out1"
}
