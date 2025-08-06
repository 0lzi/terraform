# ==================================================================
# Firewall FORWARD Filter Rules
# ensure place_before = "" is included for firewall rule order
# ==================================================================
resource "routeros_ip_firewall_filter" "allow_mgmt_forward" {
  action           = "accept"
  chain            = "forward"
  comment          = "Allow MGMT anywhere"
  src_address_list = "MGMT"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "allow_guest_portal" {
  action           = "accept"
  chain            = "forward"
  comment          = "Allow Guest to portal"
  src_address_list = "GUEST"
  dst_address      = "10.18.10.2"
  place_before     = routeros_ip_firewall_filter.drop_guest_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "drop_guest_to_rfc1918" {
  action           = "drop"
  chain            = "forward"
  comment          = "Drop Guest to rfc1918 addresses"
  src_address_list = "GUEST"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "drop_dev_to_rfc1918" {
  action           = "drop"
  chain            = "forward"
  comment          = "Drop DEV to rfc1918 addresses"
  src_address_list = "DEV"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "drop_iot_to_rfc1918" {
  action           = "drop"
  chain            = "forward"
  comment          = "Drop IoT to rfc1918 addresses"
  src_address_list = "IOT"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "home_to_traefik" {
  action           = "accept"
  chain            = "forward"
  comment          = "Allow HOME to Traefik"
  src_address_list = "HOME"
  dst_address      = routeros_ip_dns_record.traefik.address
  place_before     = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
  }


resource "routeros_ip_firewall_filter" "home_to_immich" {
  action           = "accept"
  chain            = "forward"
  comment          = "Allow HOME to Immich"
  src_address_list = "HOME"
  dst_address      = routeros_ip_dns_record.immich-prod.address
  place_before     = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "drop_home_to_rfc1918" {
  action           = "drop"
  chain            = "forward"
  comment          = "Drop HOME to rfc1918 addresses"
  src_address_list = "HOME"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

