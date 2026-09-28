variable "dhcp_leases" {
  description = "DHCP leases and DNS information for Proxmox instances."

  type = map(object({
    mac_address = string
    address     = string
    server      = string
    dns_domain  = string
  }))
}
