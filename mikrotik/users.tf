# ====================================
# System Users
# ====================================
resource "routeros_system_user" "terraform" {
  name     = "terraform"
  address  = "10.18.10.0/24"
  group    = "full"
  password = var.mikrotik_password
  comment  = "Terraform"
}

resource "routeros_system_user" "oli" {
  name     = "oli"
  address  = "192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"
  group    = "full"
  password = var.user_password
  comment  = "Admin"
}
