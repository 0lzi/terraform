# =====================================
# LAN ADDRESS
# =====================================
resource "routeros_ip_address" "lan" {
  address   = "192.168.1.254/24"
  interface = "bridge"
  network   = "192.168.1.0"
  comment   = "LAN"
}

# =====================================
# MGMT ADDRESS
# =====================================
resource "routeros_ip_address" "mgmt" {
  address   = "10.18.10.1/24"
  interface = "vlan10"
  network   = "10.18.10.0"
  comment   = "MGMT"
}

# =====================================
# PROD ADDRESS
# =====================================
resource "routeros_ip_address" "prod" {
  address   = "10.18.20.1/24"
  interface = "vlan20"
  network   = "10.18.20.0"
  comment   = "PROD"
}

# =====================================
# DEV ADDRESS
# =====================================
resource "routeros_ip_address" "dev" {
  address   = "10.18.30.1/24"
  interface = "vlan30"
  network   = "10.18.30.0"
  comment   = "DEV"
}

# =====================================
# IoT ADDRESS
# =====================================
resource "routeros_ip_address" "iot" {
  address   = "10.18.40.1/24"
  interface = "vlan40"
  network   = "10.18.40.0"
  comment   = "IoT"
}

# =====================================
# HOME ADDRESS
# =====================================
resource "routeros_ip_address" "home" {
  address   = "10.18.50.1/24"
  interface = "vlan50"
  network   = "10.18.50.0"
  comment   = "HOME"
}

# =====================================
# Guest ADDRESS
# =====================================
resource "routeros_ip_address" "guest" {
  address   = "192.168.100.1/24"
  interface = "vlan100"
  network   = "192.168.100.0"
  comment   = "Guest"
}

# =====================================
# Wireguard ADDRESS
# =====================================
resource "routeros_ip_address" "wireguard" {
  address   = "10.10.0.1/24"
  interface = "wireguard1"
  network   = "10.10.0.0"
  comment   = "Wireguard"
}
