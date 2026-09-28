module "proxmox" {
  source = "../modules/proxmox-vm"

  instances = var.instances
  ssh_keys  = var.ssh_keys
}

module "mikrotik" {
  source = "../modules/mikrotik-leases"

  dhcp_leases = module.proxmox.instances
}
