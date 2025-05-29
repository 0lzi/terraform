resource "routeros_ip_firewall_nat" "src_nat" {
  action           = "masquerade"
  comment          = "RFC1918-NAT"
  chain            = "srcnat"
  src_address_list = "RFC1918"
  out_interface    = "pppoe-out1"
}

resource "routeros_ip_firewall_nat" "dnat_01" {
  action           = "dst-nat"
  comment          = "Docker SWAG HTTPS"
  chain            = "dstnat"
  to_addresses     = "192.168.1.153"
  to_ports         = "443"
  dst_address_list = "WAN"
  dst_port         = "443"
  protocol         = "tcp"
}

resource "routeros_ip_firewall_nat" "dnat_02" {
  action           = "dst-nat"
  comment          = "Docker SWAG HTTP"
  chain            = "dstnat"
  to_addresses     = "192.168.1.153"
  to_ports         = "80"
  dst_address_list = "WAN"
  dst_port         = "80"
  protocol         = "tcp"
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
}

resource "routeros_ip_firewall_nat" "hairpin_nat_01" {
  action           = "masquerade"
  comment          = "Hairpin NAT for DOCKER"
  chain            = "srcnat"
  dst_address    = "192.168.1.153"
  src_address_list = "RFC1918"
  protocol         = "tcp"
  out_interface    = "bridge"
}

