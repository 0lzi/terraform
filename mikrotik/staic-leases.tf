# =====================================
# Static Leases PROD
# =====================================
resource "routeros_ip_dhcp_server_lease" "pi_hole_1" {
  address     = "10.18.20.20"
  mac_address = "BC:24:11:C8:31:4F"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "pi_hole_2" {
  address     = "10.18.20.21"
  mac_address = "BC:24:11:F1:4B:09"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "backblaze" {
  address     = "10.18.20.23"
  mac_address = "BC:24:11:3D:74:B3"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "lancache" {
  address     = "10.18.20.24"
  mac_address = "BC:24:11:E4:5A:90"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "docker_1" {
  address     = "10.18.20.25"
  mac_address = "bc:24:11:95:87:39"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "immich-prod" {
  address     = "10.18.20.26"
  mac_address = "BC:24:11:40:CD:EB"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "immich-home" {
  address     = "10.18.50.26"
  mac_address = "BC:24:11:78:4B:91"
  server      = "HOME"
}

