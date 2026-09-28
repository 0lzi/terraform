# For Instances that do not play nice with the module

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
  hastate            = "started"
  start_at_node_boot = false
  ciuser             = "oli"
  sshkeys            = join("\n", var.ssh_keys)
  ipconfig0          = "ip=dhcp"

  startup_shutdown {
    order            = -1
    shutdown_timeout = -1
    startup_delay    = -1
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
  # bootdisk           = "scsi1"
  boot               = "order=scsi1;net0"
  agent              = 0
  tags               = "prod,linux,home-automation"
  hastate            = "stopped"
  power_state        = "stopped"
  ipconfig0          = "ip=dhcp"
  bios               = "ovmf"
  start_at_node_boot = false

  startup_shutdown {
    order            = -1
    shutdown_timeout = -1
    startup_delay    = -1
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
