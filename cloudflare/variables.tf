
variable "dns_record" {
  type = map(object({
    name    = string
    content   = optional(string)
    type = string
  }))
}

variable "GITLAB_HOST" {
  type = string
}

variable "PROJECT_ID" {
  type = string
}

variable "STATE_NAME" {
  type = string
}

