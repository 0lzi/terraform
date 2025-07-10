data "vault_policy_document" "everyone" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = "allow all on secrets"
  }
}

resource "vault_policy" "everyone" {
  name   = "everyone policy"
  policy = data.vault_policy_document.everyone.hcl
}

