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
# Will be migrating to DNS Server instead of on Mikrotik
# =====================================
resource "routeros_ip_dns_record" "desktop" {
  name    = "desktop.0lzi.com"
  address = routeros_ip_dhcp_server_lease.desktop.address
  type    = "A"
}

resource "routeros_ip_dns_record" "max-pc" {
  name    = "max-pc.home.0lzi.com"
  address = routeros_ip_dhcp_server_lease.max-pc.address
  type    = "A"
}

resource "routeros_ip_dns_record" "lancache" {
  name    = "lancache.prod.0lzi.com"
  address = routeros_ip_dhcp_server_lease.lancache.address
  type    = "A"
}

resource "routeros_ip_dns_record" "docker_1" {
  name    = "docker-1.prod.0lzi.com"
  address = routeros_ip_dhcp_server_lease.docker_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "immich-prod" {
  name    = "immich.prod.0lzi.com"
  address = routeros_ip_dhcp_server_lease.immich-prod.address
  type    = "A"
}

resource "routeros_ip_dns_record" "immich-home" {
  name    = "immich.home.0lzi.com"
  address = routeros_ip_dhcp_server_lease.immich-home.address
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_1" {
  name    = "pve1.mgmt.0lzi.com"
  address = "10.18.10.10"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_2" {
  name    = "pve2..mgmt.0lzi.com"
  address = "10.18.10.11"
  type    = "A"
}

resource "routeros_ip_dns_record" "pve_3" {
  name    = "pve3.mgmt.0lzi.com"
  address = "10.18.10.12"
  type    = "A"
}

resource "routeros_ip_dns_record" "mikrotik" {
  name    = "mikrotik.mgmt.0lzi.com"
  address = "10.18.10.1"
  type    = "A"
}

resource "routeros_ip_dns_record" "ap_01" {
  name    = "ap-01.mgmt.0lzi.com"
  address = "10.18.10.2"
  type    = "A"
}

resource "routeros_ip_dns_record" "cisco_router" {
  name    = "cisco-router.mgmt.0lzi.com"
  address = "10.18.10.3"
  type    = "A"
}

resource "routeros_ip_dns_record" "loft_switch" {
  name    = "loft-switch.mgmt.0lzi.com"
  address = "10.18.50.32"
  type    = "A"
}

resource "routeros_ip_dns_record" "traefik-prod" {
  name    = "traefik.prod.0lzi.com"
  address = "10.18.20.200"
  type    = "A"
}

resource "routeros_ip_dns_record" "traefik" {
  name    = "traefik.0lzi.com"
  cname = routeros_ip_dns_record.traefik-prod.address
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "vault" {
  name    = "vault.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "consul" {
  name    = "consul.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "immich" {
  name    = "photos.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "proxmox" {
  name    = "pve.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "gitlab" {
  name    = "gitlab.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "gitlab-registry" {
  name    = "registry.gitlab.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "grafana" {
  name    = "grafana.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "home-assistant" {
  name    = "home-assistant.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "loki" {
  name    = "loki.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "mimir" {
  name    = "mimir.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "nextcloud" {
  name    = "nextcloud.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

resource "routeros_ip_dns_record" "crowdsec" {
  name    = "crowdsec.0lzi.com"
  cname = routeros_ip_dns_record.traefik.name
  type    = "CNAME"
}

# resource "routeros_ip_dns_record" "dns-internal" {
#   name    = "dns.prod.0lzi.com"
#   cname   = "dockerhost-1.0lzi.com"
#   type    = "cname"
# }
#
# resource "routeros_ip_dns_record" "dns" {
#   name    = "dns.0lzi.com"
#   cname   = routeros_ip_dns_record.traefik.name
#   type    = "CNAME"
# }
