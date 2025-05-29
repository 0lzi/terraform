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
  comment    = "MGMT"
  gateway    = "10.18.10.1"
  dns_server = ["10.18.20.21", "10.18.20.20"]
}

resource "routeros_ip_dhcp_server" "mgmt" {
  name         = "MGMT"
  comment      = "MGMT"
  address_pool = "MGMT"
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
  comment    = "PROD"
  gateway    = "10.18.20.1"
  dns_server = ["10.18.20.21", "10.18.20.20"]
}

resource "routeros_ip_dhcp_server" "prod" {
  name         = "PROD"
  comment      = "PROD"
  address_pool = "PROD"
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
  comment    = "DEV"
  gateway    = "10.18.30.1"
  dns_server = ["10.18.20.21", "10.18.20.20"]
}

resource "routeros_ip_dhcp_server" "dev" {
  name         = "DEV"
  comment      = "DEV"
  address_pool = "DEV"
  interface    = "vlan30"
}
# =====================================
# IoT DHCP
# =====================================
resource "routeros_ip_pool" "iot" {
  name    = "IoT"
  comment = "IoT"
  ranges  = ["10.18.10.40-10.18.40.150"]
}

resource "routeros_ip_dhcp_server_network" "iot" {
  address    = "10.18.40.0/24"
  comment    = "IoT"
  gateway    = "10.18.40.1"
  dns_server = ["8.8.8.8", "1.1.1.1"]
}

resource "routeros_ip_dhcp_server" "iot" {
  name         = "IoT"
  comment      = "IoT"
  address_pool = "IoT"
  interface    = "vlan40"
}
# =====================================
# HOME DHCP
# =====================================
resource "routeros_ip_pool" "home" {
  name    = "HOME"
  comment = "HOME"
  ranges  = ["10.18.50.20-10.18.50.50"]
}

resource "routeros_ip_dhcp_server_network" "home" {
  address    = "10.18.50.0/24"
  comment    = "HOME"
  gateway    = "10.18.50.1"
  dns_server = ["8.8.8.8", "1.1.1.1"]
}

resource "routeros_ip_dhcp_server" "home" {
  name         = "HOME"
  comment      = "HOME"
  address_pool = "HOME"
  interface    = "vlan50"
}
# =====================================
# GUEST DHCP
# =====================================
resource "routeros_ip_pool" "guest" {
  name    = "Guest"
  comment = "Guest"
  ranges  = ["192.168.100.2-192.168.100.250"]
}

resource "routeros_ip_dhcp_server_network" "guest" {
  address    = "192.168.100.0/24"
  comment    = "Guest"
  gateway    = "192.168.100.1"
  dns_server = ["8.8.8.8", "1.1.1.1"]
}

resource "routeros_ip_dhcp_server" "guest" {
  name         = "Guest"
  comment      = "Guest"
  address_pool = "Guest"
  interface    = "vlan100"
}
