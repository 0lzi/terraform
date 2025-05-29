# ===========================================
# System Setup
# ===========================================

resource "routeros_system_identity" "identity" {
  name = "Mikrotik"
}
resource "routeros_system_clock" "timezone" {
  time_zone_name       = "Europe/London"
  time_zone_autodetect = true
}

resource "routeros_system_ntp_server" "ntp_server" {
  enabled             = true
  broadcast           = true
  multicast           = true
  manycast            = true
  use_local_clock     = true
  local_clock_stratum = 3
}
