# =====================================
# Upstream DNS for Mikrotik
# =====================================
resource "routeros_dns" "dns-server" {
  allow_remote_requests = true
  servers = [ "1.1.1.1", "8.8.8.8" ]
  cache_size = 40000
  max_concurrent_queries = 200
}

# =====================================
# DNS Adlist
# =====================================

resource "routeros_ip_dns_adlist" "steven_black" {
  url        = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  ssl_verify = false
}

resource "routeros_ip_dns_adlist" "dns-blocklist" {
  url        = "https://raw.githubusercontent.com/hagezi/dns-blocklists/refs/heads/main/hosts/pro.txt"
  ssl_verify = false
}

# =====================================
# DNS Entries
# =====================================

resource "routeros_ip_dns_record" "pi_hole_1" {
  name    = "pi-hole-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.pi_hole_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "pi_hole_2" {
  name    = "pi-hole-2.0lzi.com"
  address = routeros_ip_dhcp_server_lease.pi_hole_2.address
  type    = "A"
}

resource "routeros_ip_dns_record" "lancache" {
  name    = "lancache.0lzi.com"
  address = routeros_ip_dhcp_server_lease.lancache.address
  type    = "A"
}

resource "routeros_ip_dns_record" "docker_1" {
  name    = "docker-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.docker_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_1" {
  name    = "pve1.0lzi.com"
  address = "10.18.10.10"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_2" {
  name    = "pve2.0lzi.com"
  address = "10.18.10.11"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_3" {
  name    = "pve3.0lzi.com"
  address = "10.18.10.12"
  type    = "A"
}

resource "routeros_ip_dns_record" "mikrotik" {
  name    = "mikrotik.0lzi.internal"
  address = "10.18.10.1"
  type    = "A"
}

resource "routeros_ip_dns_record" "ap_01" {
  name    = "ap-01.0lzi.internal"
  address = "10.18.10.2"
  type    = "A"
}

# =====================================
# DNS Adlist
# =====================================

resource "routeros_ip_dns_adlist" "steven_black" {
  url        = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  ssl_verify = false
}

resource "routeros_ip_dns_adlist" "dns-blocklist" {
  url        = "https://raw.githubusercontent.com/hagezi/dns-blocklists/refs/heads/main/hosts/pro.txt"
  ssl_verify = false
}

# =====================================
# DNS Entries
# =====================================

resource "routeros_ip_dns_record" "pi_hole_1" {
  name    = "pi-hole-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.pi_hole_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "pi_hole_2" {
  name    = "pi-hole-2.0lzi.com"
  address = routeros_ip_dhcp_server_lease.pi_hole_2.address
  type    = "A"
}

resource "routeros_ip_dns_record" "lancache" {
  name    = "lancache.0lzi.com"
  address = routeros_ip_dhcp_server_lease.lancache.address
  type    = "A"
}

resource "routeros_ip_dns_record" "docker_1" {
  name    = "docker-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.docker_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_1" {
  name    = "pve1.0lzi.com"
  address = "10.18.10.10"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_2" {
  name    = "pve2.0lzi.com"
  address = "10.18.10.11"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_3" {
  name    = "pve3.0lzi.com"
  address = "10.18.10.12"
  type    = "A"
}

resource "routeros_ip_dns_record" "mikrotik" {
  name    = "mikrotik.0lzi.internal"
  address = "10.18.10.1"
  type    = "A"
}

resource "routeros_ip_dns_record" "ap_01" {
  name    = "ap-01.0lzi.internal"
  address = "10.18.10.2"
  type    = "A"
}
