variable "instances" {
  description = "Proxmox VM instances."

  type = map(object({
    node       = optional(string, "pve3")
    domain     = optional(string, "0lzi.com")
    clone      = optional(string, "ubuntu24.04-cloud")
    full_clone = optional(bool, true)
    cpu = optional(object({
      cores = optional(number, 2)
      type  = optional(string, "kvm64")
    }), {})

    memory  = optional(number, 1024)
    balloon = optional(number, 1024)

    scsihw             = optional(string, "virtio-scsi-pci")
    bootdisk           = optional(string, "scsi0")
    bios               = optional(string, "seabios")
    os_type            = optional(string, "cloud-init")
    agent              = optional(number, 1)
    tags               = optional(list(string), [])
    hastate            = optional(string, "started")
    power_state        = optional(string, "started")
    start_at_node_boot = optional(bool, false)
    ciuser             = optional(string, "oli")
    sshkeys            = optional(string)
    ipconfig0          = optional(string, "ip=dhcp")
    network = optional(object({
      bridge     = optional(string, "DEV")
      id         = optional(number, 0)
      model      = optional(string, "virtio")
      ip_address = optional(string)
    }))
    startup_shutdown = optional(object({
      order            = optional(number, -1)
      shutdown_timeout = optional(number, -1)
      startup_delay    = optional(number, -1)
    }), {})
    vga = optional(object({
      type = optional(string, "std")
    }), {})
    disks = optional(map(object({
      size       = number
      slot       = number
      storage    = optional(string, "ceph_vmdisks")
      emulatessd = optional(bool, true)
    })), {})
    cloud_init_file = optional(string)
  }))
}

variable "ssh_keys" {
  description = "SSH public keys to add to cloud-init VMs."
  type        = list(string)
  default     = []
}
