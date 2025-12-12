# ==================================================================
# Firewall FORWARD Filter Rules
# ensure place_before = "" is included for firewall rule order
# ==================================================================
resource "routeros_ip_firewall_filter" "fast_track_allow_established_related_forward" {
  action           = "fasttrack-connection"
  comment          = "Allow established related fasttrack"
  disabled         = false
  chain            = "forward"
  hw_offload       = true
  connection_state = "established,related"
  place_before     = routeros_ip_firewall_filter.allow_established_related_forward.id
}

resource "routeros_ip_firewall_filter" "allow_established_related_forward" {
  action           = "accept"
  comment          = "Allow established related forwarding"
  disabled         = false
  chain            = "forward"
  connection_state = "established,related"
  place_before     = routeros_ip_firewall_filter.drop_invalid.id
}

resource "routeros_ip_firewall_filter" "allow_mgmt_forward" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "Allow MGMT anywhere"
  src_address_list = "MGMT"
  dst_address_list = "RFC1918"
  connection_state = "new"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "allow_guest_portal" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "Allow GUEST to portal"
  src_address_list = "GUEST"
  dst_address      = "10.18.10.2"
  place_before     = routeros_ip_firewall_filter.drop_guest_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "drop_prod_to_rfc1918" {
  action           = "drop"
  disabled         = false
  chain            = "forward"
  comment          = "Drop PROD to rfc1918 addresses"
  src_address_list = "PROD"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "drop_guest_to_rfc1918" {
  action           = "drop"
  disabled         = false
  chain            = "forward"
  comment          = "Drop GUEST to rfc1918 addresses"
  src_address_list = "GUEST"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "drop_dev_to_rfc1918" {
  action           = "drop"
  disabled         = false
  chain            = "forward"
  comment          = "Drop DEV to rfc1918 addresses"
  src_address_list = "DEV"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "drop_iot_to_rfc1918" {
  action           = "drop"
  disabled         = false
  chain            = "forward"
  comment          = "Drop IoT to rfc1918 addresses"
  src_address_list = "IOT"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

resource "routeros_ip_firewall_filter" "home_to_traefik" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "Allow HOME to Traefik"
  src_address_list = "HOME"
  dst_address      = routeros_ip_dns_record.traefik.address
  place_before     = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "home_to_immich" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "Allow HOME to Immich"
  src_address_list = "HOME"
  dst_address      = routeros_ip_dns_record.immich-prod.address
  place_before     = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "home_to_home-assistant" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "allow HOME to Home Assistant"
  src_address_list = "HOME"
  dst_address      = "10.18.40.100"
  place_before     = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "traefik_to_home-assistant" {
  action       = "accept"
  disabled     = false
  chain        = "forward"
  comment      = "allow traefik to home assistant"
  src_address  = routeros_ip_dns_record.traefik.address
  dst_address  = "10.18.40.100"
  place_before = routeros_ip_firewall_filter.drop_home_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "traefik_to_pve" {
  action           = "accept"
  disabled         = false
  chain            = "forward"
  comment          = "allow traefik to PVE"
  src_address      = routeros_ip_dns_record.traefik.address
  dst_address_list = "PVE"
  place_before     = routeros_ip_firewall_filter.drop_prod_to_rfc1918.id
}

resource "routeros_ip_firewall_filter" "drop_home_to_rfc1918" {
  action           = "drop"
  disabled         = false
  chain            = "forward"
  comment          = "Drop HOME to rfc1918 addresses"
  src_address_list = "HOME"
  dst_address_list = "RFC1918"
  place_before     = routeros_ip_firewall_filter.default_drop.id
}

