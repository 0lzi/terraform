locals {
  docker_hosts = {
    "dockerhost-0" = {
      macaddr = "BC:24:11:F4:1C:B6"
      node    = "pve2"
    }
    "dockerhost-1" = {
      macaddr = "BC:24:11:3C:18:24"
      node    = "pve3"
    }
    "dockerhost-2" = {
      macaddr = "BC:24:11:6A:78:65"
      node    = "pve2"
    }
  }
  consul_hosts = {
    "consul-0" = {
      macaddr = "BC:24:11:1A:3D:3B"
      node    = "pve3"
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
  vault_hosts = {
    "vault-0" = {
      macaddr = "BC:24:11:1A:3A:3A"
      node    = "pve2"
    }
    "vault-1" = {
      macaddr = "BC:24:11:E8:9A:A8"
      node    = "pve3"
    }
    "vault-2" = {
      macaddr = "BC:24:11:65:3A:6E"
      node    = "pve2"
    }
  }
  ssh_keys = join("\n", [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKB4x+MIBnxh+dEksA4BNVH6aB4hmTH1mOn+jQL0Slok",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO0H/Ljg4QTkUNnTnhVo2ksb91xaIvWelSEL/jxjfAOK",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbNiui4JpQuOtMO3qUh9W9vp57TczrHBCQhIegmTRBc",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHbTW+h27gxALZQ+KXVU1IbR3I9EAEQRD8DVADGxmsrO",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGhRnQVXtNDJBZ0Aeq58u8bvyFVcY7QFq8V+JIJukWfG"
  ])
}

resource "proxmox_vm_qemu" "alloy" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  name        = "alloy"
  target_node = "pve3"
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 2
    type  = "kvm64"
  }
  memory             = 1024
  balloon            = 1024
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "tmux,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"
  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
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
          size       = "20G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "MGMT"
  }
}

resource "proxmox_vm_qemu" "tmux" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  name        = "tmux"
  target_node = "pve3"
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory             = 4096
  balloon            = 1024
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "tmux,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"
  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
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
          size       = "50G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "MGMT"
  }
}

resource "proxmox_vm_qemu" "consul_hosts" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  for_each    = local.consul_hosts
  name        = each.key
  target_node = each.value.node
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 2
    type  = "kvm64"
  }
  memory             = 2048
  balloon            = 512
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "docker,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }

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


resource "proxmox_vm_qemu" "vault_hosts" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  for_each    = local.vault_hosts
  name        = each.key
  target_node = each.value.node
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 2
    type  = "kvm64"
  }
  memory             = 2048
  balloon            = 512
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "docker,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
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
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  for_each    = local.docker_hosts
  name        = each.key
  target_node = each.value.node
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory             = 4096
  balloon            = 512
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "docker,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
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

resource "proxmox_vm_qemu" "gitlab" {
  lifecycle { # This instance was created outside of Terraform
    prevent_destroy = true
    ignore_changes  = all
  }
  name        = "gitlab"
  target_node = "pve1"
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 6
    type  = "kvm64"
  }
  memory             = 6144
  balloon            = 6144
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "docker,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
  # VGA
  vga {
    type = "std"
  }
  # System disk
  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "ceph_vmdisks"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size       = "15G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
      scsi1 {
        disk {
          size       = "100G"
          storage    = "ceph_vm-data-disks"
          emulatessd = true
        }
      }
    }
  }
  network {
    id      = 0
    model   = "virtio"
    bridge  = "PROD"
    macaddr = "BC:24:11:B4:A2:10"
  }
}

resource "proxmox_vm_qemu" "gitlab-runner-1" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  name        = "gitlab-runner-1"
  target_node = "pve2"
  clone       = var.vm_template
  full_clone  = true
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory             = 4096
  balloon            = 1024
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi0"
  os_type            = "cloud-init"
  agent              = 1
  tags               = "gitlab,prod,linux"
  hagroup            = "prod"
  hastate            = "started"
  start_at_node_boot = true
  ciuser             = "oli"
  sshkeys            = local.ssh_keys
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
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
          size       = "50G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "MGMT"
  }
}


resource "proxmox_vm_qemu" "home-assistant" {
  lifecycle {
    ignore_changes = [
      target_node
    ]
  }
  name        = "home-assistant"
  target_node = "pve2"
  cpu {
    cores = 4
    type  = "kvm64"
  }
  memory             = 4096
  balloon            = 1024
  scsihw             = "virtio-scsi-pci"
  bootdisk           = "scsi1"
  agent              = 0
  tags               = "gitlab,prod,linux,home-automation"
  hagroup            = "prod"
  hastate            = "started"
  ipconfig0          = "ip=dhcp"
  bios               = "ovmf"
  start_at_node_boot = true

  startup_shutdown {
    order = -1
    shutdown_timeout = -1
    startup_delay = -1
  }
  # VGA
  vga {
    type = "std"
  }

  # System disk
  disks {
    scsi {
      scsi1 {
        disk {
          size       = "32G"
          storage    = "ceph_vmdisks"
          emulatessd = true
        }
      }
    }
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "IoT"
  }
}

resource "routeros_ip_dhcp_server_lease" "home-assistant" {
  address     = "10.18.40.100"
  mac_address = proxmox_vm_qemu.home-assistant.network[0].macaddr
  server      = "IoT"

  depends_on = [proxmox_vm_qemu.home-assistant]
}

resource "routeros_ip_dhcp_server_lease" "gitlab" {
  address     = "10.18.20.27"
  mac_address = proxmox_vm_qemu.gitlab.network[0].macaddr
  server      = "PROD"

  depends_on = [proxmox_vm_qemu.gitlab]
}

resource "routeros_ip_dhcp_server_lease" "gitlab-runner-1" {
  address     = "10.18.10.101"
  mac_address = proxmox_vm_qemu.gitlab-runner-1.network[0].macaddr
  server      = "MGMT"

  depends_on = [proxmox_vm_qemu.gitlab-runner-1]
}

resource "routeros_ip_dhcp_server_lease" "alloy" {
  address     = "10.18.10.102"
  mac_address = proxmox_vm_qemu.alloy.network[0].macaddr
  server      = "MGMT"

  depends_on = [proxmox_vm_qemu.alloy]
}

resource "routeros_ip_dhcp_server_lease" "tmux" {
  address     = "10.18.10.100"
  mac_address = proxmox_vm_qemu.tmux.network[0].macaddr
  server      = "MGMT"

  depends_on = [proxmox_vm_qemu.tmux]
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

resource "routeros_ip_dhcp_server_lease" "vault_0" {
  address     = "10.18.20.110"
  mac_address = "BC:24:11:1A:3A:3A"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "vault_1" {
  address     = "10.18.20.111"
  mac_address = "BC:24:11:E8:9A:A8"
  server      = "PROD"
}

resource "routeros_ip_dhcp_server_lease" "vault_2" {
  address     = "10.18.20.112"
  mac_address = "BC:24:11:65:3A:6E"
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

resource "routeros_ip_dns_record" "vault_0" {
  name    = "vault-0.0lzi.com"
  address = routeros_ip_dhcp_server_lease.vault_0.address
  type    = "A"
}

resource "routeros_ip_dns_record" "vault_1" {
  name    = "vault-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.vault_1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "vault_2" {
  name    = "vault-2.0lzi.com"
  address = routeros_ip_dhcp_server_lease.vault_2.address
  type    = "A"
}

resource "routeros_ip_dns_record" "alloy" {
  name    = "alloy.0lzi.com"
  address = routeros_ip_dhcp_server_lease.alloy.address
  type    = "A"
}

resource "routeros_ip_dns_record" "tmux" {
  name    = "tmux.0lzi.com"
  address = routeros_ip_dhcp_server_lease.tmux.address
  type    = "A"
}

resource "routeros_ip_dns_record" "gitlab-runner-1" {
  name    = "gitlab-runner-1.0lzi.com"
  address = routeros_ip_dhcp_server_lease.gitlab-runner-1.address
  type    = "A"
}

resource "routeros_ip_dns_record" "gitlab-internal" {
  name    = "gitlab.0lzi.internal"
  address = routeros_ip_dhcp_server_lease.gitlab.address
  type    = "A"
}

resource "routeros_ip_dns_record" "registry-gitlab-internal" {
  name    = "registry.gitlab.0lzi.internal"
  address = routeros_ip_dhcp_server_lease.gitlab.address
  type    = "A"
}

resource "routeros_ip_dns_record" "home-assistant-internal" {
  name    = "home-assistant.0lzi.internal"
  address = routeros_ip_dhcp_server_lease.home-assistant.address
  type    = "A"
}
