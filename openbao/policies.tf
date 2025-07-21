data "vault_policy_document" "all" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "allow all on secrets"
  }
}

resource "vault_policy" "all" {
  name   = "all"
  policy = data.vault_policy_document.everyone.hcl
}

