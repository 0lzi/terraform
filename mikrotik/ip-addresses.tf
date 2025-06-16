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

resource "routeros_ip_address" "mgmt-vrrp" {
  address   = "10.18.10.254/24"
  interface = "mgmt-vrrp"
  network   = "10.18.10.0"
  comment   = "mgmt"
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


resource "routeros_ip_address" "prod-vrrp" {
  address   = "10.18.20.254/24"
  interface = "prod-vrrp"
  network   = "10.18.20.0"
  comment   = "prod"
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


resource "routeros_ip_address" "dev-vrrp" {
  address   = "10.18.30.254/24"
  interface = "mgmt-vrrp"
  network   = "10.18.30.0"
  comment   = "dev"
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


resource "routeros_ip_address" "iot-vrrp" {
  address   = "10.18.40.254/24"
  interface = "iot-vrrp"
  network   = "10.18.40.0"
  comment   = "iot"
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


resource "routeros_ip_address" "home-vrrp" {
  address   = "10.18.50.254/24"
  interface = "home-vrrp"
  network   = "10.18.50.0"
  comment   = "home"
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


resource "routeros_ip_address" "guest-vrrp" {
  address   = "192.168.100.254/24"
  interface = "guest-vrrp"
  network   = "192.168.100.0"
  comment   = "guest"
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

resource "routeros_ip_address" "wireguard-vrrp" {
  address   = "10.10.0.254/24"
  interface = "wireguard1"
  network   = "10.10.0.0"
  comment   = "wireguard-vrrp"
}
