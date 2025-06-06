# =====================================
# MGMT DHCP
# =====================================
resource "routeros_ip_pool" "mgmt" {
  name    = "MGMT"
  comment = "MGMT"
  ranges  = ["10.18.10.20-10.18.10.50"]
}

resource "routeros_ip_dhcp_server_network" "mgmt" {
  address    = "10.18.10.0/24"
  comment    = routeros_ip_pool.mgmt.comment
  gateway    = "10.18.10.1"
  dns_server = ["10.18.10.1"]
  domain     = "0lzi.internal"
}

resource "routeros_ip_dhcp_server" "mgmt" {
  name         = routeros_ip_pool.mgmt.name
  comment      = routeros_ip_pool.mgmt.comment
  address_pool = routeros_ip_pool.mgmt.name
  interface    = "vlan10"
}

# =====================================
# PROD DHCP
# =====================================
resource "routeros_ip_pool" "prod" {
  name    = "PROD"
  comment = "PROD"
  ranges  = ["10.18.20.20-10.18.20.200"]
}

resource "routeros_ip_dhcp_server_network" "prod" {
  address    = "10.18.20.0/24"
  comment    = routeros_ip_pool.prod.comment
  gateway    = "10.18.20.1"
  dns_server = ["10.18.20.1"]
  domain     = "0lzi.com"
}

resource "routeros_ip_dhcp_server" "prod" {
  name         = routeros_ip_pool.prod.name
  comment      = routeros_ip_pool.prod.comment
  address_pool = routeros_ip_pool.prod.name
  interface    = "vlan20"
}

# =====================================
# DEV DHCP
# =====================================
resource "routeros_ip_pool" "dev" {
  name    = "DEV"
  comment = "DEV"
  ranges  = ["10.18.30.20-10.18.30.200"]
}

resource "routeros_ip_dhcp_server_network" "dev" {
  address    = "10.18.30.0/24"
  comment    = routeros_ip_pool.dev.comment
  gateway    = "10.18.30.1"
  dns_server = ["10.18.30.1"]
  domain     = "0lzi.internal"
}

resource "routeros_ip_dhcp_server" "dev" {
  name         = routeros_ip_pool.dev.name
  comment      = routeros_ip_pool.dev.comment
  address_pool = routeros_ip_pool.dev.name
  interface    = "vlan30"
}

# =====================================
# IoT DHCP
# =====================================
resource "routeros_ip_pool" "iot" {
  name    = "IoT"
  comment = "IoT"
  ranges  = ["10.18.40.20-10.18.40.200"]
}

resource "routeros_ip_dhcp_server_network" "iot" {
  address    = "10.18.40.0/24"
  comment    = routeros_ip_pool.iot.comment
  gateway    = "10.18.40.1"
  dns_server = ["10.18.40.1"]
}

resource "routeros_ip_dhcp_server" "iot" {
  name         = routeros_ip_pool.iot.name
  comment      = routeros_ip_pool.iot.comment
  address_pool = routeros_ip_pool.iot.name
  interface    = "vlan40"
}

# =====================================
# HOME DHCP
# =====================================
resource "routeros_ip_pool" "home" {
  name    = "HOME"
  comment = "HOME"
  ranges  = ["10.18.50.20-10.18.50.200"]
}

resource "routeros_ip_dhcp_server_network" "home" {
  address    = "10.18.50.0/24"
  comment    = routeros_ip_pool.home.comment
  gateway    = "10.18.50.1"
  dns_server = ["10.18.50.1"]
  domain     = "internal"
}

resource "routeros_ip_dhcp_server" "home" {
  name         = routeros_ip_pool.home.name
  comment      = routeros_ip_pool.home.comment
  address_pool = routeros_ip_pool.home.name
  interface    = "vlan50"
}

# =====================================
# GUEST DHCP
# =====================================
resource "routeros_ip_pool" "guest" {
  name    = "Guest"
  comment = "Guest"
  ranges  = ["192.168.100.20-192.168.100.200"]
}

resource "routeros_ip_dhcp_server_network" "guest" {
  address    = "192.168.100.0/24"
  comment    = routeros_ip_pool.guest.comment
  gateway    = "192.168.100.1"
  dns_server = ["8.8.8.8", "1.1.1.1"]
}

resource "routeros_ip_dhcp_server" "guest" {
  name         = routeros_ip_pool.guest.name
  comment      = routeros_ip_pool.guest.comment
  address_pool = routeros_ip_pool.guest.name
  interface    = "vlan100"
}
