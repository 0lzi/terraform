output "instances" {
  description = "MAC addresses and DHCP configuration for each VM."

  value = {
    for name, vm in proxmox_vm_qemu.instance :
    name => {
      mac_address = vm.network[0].macaddr
      address     = var.instances[name].network.ip_address
      server      = var.instances[name].network.bridge
      dns_domain  = var.instances[name].domain
    }
  }
}
