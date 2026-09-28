locals {
  instance_disks = {
    for instance_name, instance in var.instances :
    instance_name => {
      for slot, disk in instance.disks :
      slot => merge(disk, {
        scsi_slot = index(keys(instance.disks), slot)
      })
    }
  }
}

resource "proxmox_vm_qemu" "instance" {
  for_each = var.instances

  lifecycle {
    ignore_changes = [
      target_node,
    ]
  }

  name                   = each.key
  target_node            = each.value.node
  define_connection_info = false
  clone                  = each.value.clone
  full_clone             = each.value.full_clone
  cpu {
    cores = each.value.cpu.cores
    type  = each.value.cpu.type
  }
  memory             = each.value.memory
  balloon            = each.value.balloon
  scsihw             = each.value.scsihw
  bootdisk           = each.value.bootdisk
  bios               = each.value.bios
  os_type            = each.value.os_type
  agent              = each.value.agent
  tags               = join(",", each.value.tags)
  hastate            = each.value.hastate
  power_state        = each.value.power_state
  start_at_node_boot = each.value.start_at_node_boot
  ciuser             = each.value.ciuser
  sshkeys            = join("\n", var.ssh_keys)
  ipconfig0          = each.value.ipconfig0
  startup_shutdown {
    order            = each.value.startup_shutdown.order
    shutdown_timeout = each.value.startup_shutdown.shutdown_timeout
    startup_delay    = each.value.startup_shutdown.startup_delay
  }
  vga {
    type = each.value.vga.type
  }
  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "ceph_vmdisks"
        }
      }
    }
    scsi {
      # scsi0
      dynamic "scsi0" {
        for_each = {
          for name, disk in local.instance_disks[each.key] :
          name => disk
          if disk.scsi_slot == 0
        }
        content {
          disk {
            size       = scsi0.value.size
            storage    = scsi0.value.storage
            emulatessd = scsi0.value.emulatessd
          }
        }
      }
      # scsi1
      dynamic "scsi1" {
        for_each = {
          for name, disk in local.instance_disks[each.key] :
          name => disk
          if disk.scsi_slot == 1
        }
        content {
          disk {
            size       = scsi1.value.size
            storage    = scsi1.value.storage
            emulatessd = scsi1.value.emulatessd
          }
        }
      }

    }
  }
  network {
    id     = each.value.network.id
    model  = each.value.network.model
    bridge = each.value.network.bridge
  }
}
