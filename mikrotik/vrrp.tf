# ==================================================================
# VRRP Sync
# ==================================================================


# ==================================================================
# VRRP MGMT
# ==================================================================

resource "routeros_interface_vrrp" "mgmt_vrrp" {
  interface = "vlan10"
  name      = "mgmt-vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP PROD
# ==================================================================

resource "routeros_interface_vrrp" "prod_vrrp" {
  interface = "vlan20"
  name      = "prod_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP DEV
# ==================================================================

resource "routeros_interface_vrrp" "dev_vrrp" {
  interface = "vlan30"
  name      = "dev_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP IoT
# ==================================================================

resource "routeros_interface_vrrp" "iot_vrrp" {
  interface = "vlan40"
  name      = "iot_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP HOME
# ==================================================================

resource "routeros_interface_vrrp" "home_vrrp" {
  interface = "vlan50"
  name      = "home_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP Guest
# ==================================================================

resource "routeros_interface_vrrp" "guest_vrrp" {
  interface = "vlan100"
  name      = "guest_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

# ==================================================================
# VRRP Wireguard
# ==================================================================

resource "routeros_interface_vrrp" "wg_vrrp" {
  interface = "wireguard1"
  name      = "wg_vrrp"
  group_authority = "vrrp-sync"
  preemption_mode = "0"
  priority  = 100
}

