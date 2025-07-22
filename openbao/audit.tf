resource "vault_audit" "log" {
  type = "file"

  options = {
    file_path   = "/var/log/openbao/openbao"
    description = "Openbao Logs"
  }
}
