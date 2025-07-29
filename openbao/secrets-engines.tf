resource "vault_mount" "kv-v2" {
  path        = "kv"
  type        = "kv"
  description = "KV v2 Secrets engine"
  options = {
    version = "2"
    type    = "kv-v2"
  }
}
