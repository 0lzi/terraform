locals {
  docker_hosts = {
    "dockerhost-0" = {
      macaddr = "BC:24:11:F4:1C:B6"
      node    = "pve1"
    }
    "dockerhost-1" = {
      macaddr = "BC:24:11:3C:18:24"
      node    = "pve2"
    }
    "dockerhost-2" = {
      macaddr = "BC:24:11:6A:78:65"
      node    = "pve3"
    }
  }
  consul_hosts = {
    "consul-0" = {
      macaddr = "BC:24:11:1A:3D:3B"
      node    = "pve1"
    }
    "consul-1" = {
      macaddr = "BC:24:11:E8:95:A7"
      node    = "pve2"
    }
    "consul-2" = {
      macaddr = "BC:24:11:65:3C:6D"
      node    = "pve3"
    }
  }

}

resource "proxmox_vm_qemu" "consul_hosts" {
  for_each = local.consul_hosts
  name        = each.key
  target_node = each.value.node
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory    = 4096
  scsihw    = "virtio-scsi-pci"
  bootdisk  = "scsi0"
  os_type   = "cloud-init"
  agent     = 1
  tags      = "docker,prod,linux"
  hagroup   = "prod"
  hastate   = "started"
  ciuser    = "oli"
  sshkeys   = file("~/.ssh/ct-admin.pub")
  ipconfig0 = "ip=dhcp"

  # VGA
  vga {
    type = "std"
  }

  # System disk
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "ceph_vmdisks"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size       = "30G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "PROD"
    macaddr = each.value.macaddr
  }
}

resource "proxmox_vm_qemu" "docker_hosts" {
  for_each = local.docker_hosts
  name        = each.key
  target_node = each.value.node
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory    = 4096
  scsihw    = "virtio-scsi-pci"
  bootdisk  = "scsi0"
  os_type   = "cloud-init"
  agent     = 1
  tags      = "docker,prod,linux"
  hagroup   = "prod"
  hastate   = "started"
  onboot    = true
  ciuser    = "oli"
  sshkeys   = file("~/.ssh/ct-admin.pub")
  ipconfig0 = "ip=dhcp"

  # VGA
  vga {
    type = "std"
  }
  # System disk
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "ceph_vmdisks"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size       = "30G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id      = 0
    model   = "virtio"
    bridge  = "PROD"
    macaddr = each.value.macaddr
  }
}

resource "routeros_ip_dhcp_server_lease" "consul_0" {
  address     = "10.18.20.100"
  mac_address = "BC:24:11:1A:3D:3B"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "consul_1" {
  address     = "10.18.20.101"
  mac_address = "BC:24:11:E8:95:A7"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "consul_2" {
  address     = "10.18.20.102"
  mac_address = "BC:24:11:65:3C:6D"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "dockerhost_0" {
  address     = "10.18.20.200"
  mac_address = "BC:24:11:F4:1C:B6"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "dockerhost_1" {
  address     = "10.18.20.201"
  mac_address = "BC:24:11:3C:18:24"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "dockerhost_2" {
  address     = "10.18.20.202"
  mac_address = "BC:24:11:6A:78:65"
  server      = "PROD"
}

resource "routeros_ip_dns_record" "consul_0" {
  name    = "consul-0.0lzi.com"
  address = routeros_ip_dhcp_server_lease.consul_0.address
  type    = "A"
}

resource "routeros_ip_dns_record" "consul_1" {
  name    = "consul-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.consul_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "consul_2" {
  name    = "consul-2.0lzi.com"
  address = routeros_ip_dhcp_server_lease.consul_2.address
  type    = "A"
}

resource "routeros_ip_dns_record" "dockerhost_0" {
  name    = "dockerhost-0.0lzi.com"
  address = routeros_ip_dhcp_server_lease.dockerhost_0.address
  type    = "A"
}

resource "routeros_ip_dns_record" "dockerhost_1" {
  name    = "dockerhost-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.dockerhost_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "dockerhost_2" {
  name    = "dockerhost-2.0lzi.com"
  address = routeros_ip_dhcp_server_lease.dockerhost_2.address
  type    = "A"
}
