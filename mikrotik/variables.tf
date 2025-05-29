variable "mikrotik_host_url" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_username" {
  type        = string
  sensitive   = true
  description = "The username for accessing the MikroTik device."
}

variable "user_password" {
  type        = string
  sensitive   = true
  description = "The password for user"
}

variable "mikrotik_password" {
  type        = string
  sensitive   = true
  description = "The password for accessing the MikroTik device."
}

variable "mikrotik_insecure" {
  type        = bool
  default     = true
  description = "Whether to allow insecure connections to the MikroTik device."
}

variable "wan_address" {
  type        = string
  sensitive   = true
  description = "WAN addres"
}

variable "pppoe_username" {
  type        = string
  sensitive   = true
  description = "The PPPoE username."
}
variable "pppoe_password" {
  type        = string
  sensitive   = true
  description = "The PPPoE password."
}
