# ==================================================================
# Firewall NAT Rules
# ensure place_before = "" is included for firewall rule order
# ==================================================================
resource "routeros_ip_firewall_nat" "src_nat" {
  action           = "masquerade"
  comment          = "RFC1918-NAT"
  chain            = "srcnat"
  src_address_list = "RFC1918"
  out_interface    = "pppoe-out1"
  place_before     = routeros_ip_firewall_nat.dnat_01.id
}

resource "routeros_ip_firewall_nat" "dnat_01" {
  action           = "dst-nat"
  comment          = "Docker SWAG HTTPS"
  chain            = "dstnat"
  to_addresses     = routeros_ip_dns_record.traefik.address
  to_ports         = "443"
  dst_address_list = "WAN"
  dst_port         = "443"
  protocol         = "tcp"
  place_before     = routeros_ip_firewall_nat.dnat_02.id
}

resource "routeros_ip_firewall_nat" "dnat_02" {
  action           = "dst-nat"
  comment          = "Docker SWAG HTTP"
  chain            = "dstnat"
  to_addresses     = routeros_ip_dns_record.traefik.address
  to_ports         = "80"
  dst_address_list = "WAN"
  dst_port         = "80"
  protocol         = "tcp"
  place_before     = routeros_ip_firewall_nat.dnat_03.id
}

resource "routeros_ip_firewall_nat" "dnat_03" {
  action           = "dst-nat"
  comment          = "Docker WIREGUARD"
  chain            = "dstnat"
  to_addresses     = "192.168.1.153"
  to_ports         = "1988"
  dst_address_list = "WAN"
  dst_port         = "1988"
  protocol         = "udp"
  place_before     = routeros_ip_firewall_nat.hairpin_nat_01.id
}

resource "routeros_ip_firewall_nat" "hairpin_nat_01" {
  action           = "masquerade"
  comment          = "Hairpin NAT for DOCKER"
  chain            = "srcnat"
  to_addresses     = routeros_ip_dns_record.traefik.address
  src_address_list = "RFC1918"
  protocol         = "tcp"
  out_interface    = "bridge"
}
