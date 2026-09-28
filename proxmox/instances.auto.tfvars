instances = {
  alloy = {
    node = "pve3"
    tags = ["prod", "linux"]
    disks = {
      root = {
        size = 20
        slot = 0
      }
    }
    network = {
      bridge     = "MGMT"
      ip_address = "10.18.10.102"
    }
  }
  vault-0 = {
    node    = "pve1"
    tags    = ["vault", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.110"
    }
  }
  vault-1 = {
    node    = "pve2"
    tags    = ["vault", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.111"
    }
  }
  vault-2 = {
    node    = "pve3"
    tags    = ["vault", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.112"
    }
  }
  consul-0 = {
    node    = "pve1"
    tags    = ["consul", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.100"
    }
  }
  consul-1 = {
    node    = "pve2"
    tags    = ["consul", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.101"
    }
  }
  consul-2 = {
    node    = "pve3"
    tags    = ["consul", "prod", "linux"]
    memory  = 2048
    balloon = 512
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.102"
    }
  }
  dockerhost-0 = {
    node    = "pve1"
    tags    = ["docker", "prod", "linux"]
    memory  = 4096
    balloon = 512
    cpu = {
      cores = 4
    }
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.200"
    }
  }
  dockerhost-1 = {
    node    = "pve2"
    tags    = ["docker", "prod", "linux"]
    memory  = 4096
    balloon = 512
    cpu = {
      cores = 4
    }
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.201"
    }
  }
  dockerhost-2 = {
    node        = "pve3"
    tags        = ["docker", "prod", "linux"]
    memory      = 4096
    power_state = "stopped"
    hastate     = "stopped"
    balloon     = 512
    cpu = {
      cores = 4
    }
    disks = {
      root = {
        size = 30
        slot = 0
      }
    }
    network = {
      bridge     = "PROD"
      ip_address = "10.18.20.202"
    }
  }
  tmux = {
    node        = "pve3"
    tags        = ["tmux", "prod", "linux"]
    memory      = 4096
    balloon     = 1024
    power_state = "stopped"
    hastate     = "stopped"
    cpu = {
      cores = 4
    }
    disks = {
      root = {
        size = 50
        slot = 0
      }
    }
    network = {
      bridge     = "MGMT"
      ip_address = "10.18.10.100"
    }
  }
  gitlab-runner-1 = {
    node    = "pve3"
    tags    = ["gitlab-runner", "prod", "linux"]
    memory  = 4096
    balloon = 1024
    cpu = {
      cores = 4
    }
    disks = {
      root = {
        size = 50
        slot = 0
      }
    }
    network = {
      bridge     = "MGMT"
      ip_address = "10.18.10.101"
    }
  }
  # Can't get these ones working nicely yet
  #  gitlab = {
  #    node        = "pve1"
  #    domain      = "0lzi.internal"
  #    tags        = ["gitlab", "prod", "linux"]
  #    full_clone  = false
  #    memory      = 6144
  #    balloon     = 6144
  #    cpu = {
  #      cores = 6
  #      type = "host"
  #    }
  #    disks = {
  #      root = {
  #        size = 50
  #        slot = 0
  #        storage = "ceph_vmdisks"
  #      }
  #      data = {
  #        size = 100
  #        slot = 1
  #        storage = "ceph_vm-data-disks"
  #      }
  #    }
  #    network = {
  #      bridge     = "PROD"
  #      ip_address = "10.18.20.27"
  #    }
  #  }
  #  home-assistant = {
  #    node        = "pve2"
  #    tags        = ["home-assistant", "prod", "linux"]
  #    agent       = 0
  #    bootdisk    = "scsi1"
  #    clone       = null
  #    full_clone  = false
  #    bios        = "ovmf"
  #    memory      = 4096
  #    power_state = "stopped"
  #    hastate     = "stopped"
  #    balloon     = 1024
  #    cpu = {
  #      cores = 4
  #    }
  #    disks = {
  #      root = {
  #        size = 32
  #        slot = 1
  #      }
  #    }
  #    network = {
  #      bridge     = "IoT"
  #      ip_address = "10.18.40.101"
  #    }
  #    vga = null
  #  }
}

