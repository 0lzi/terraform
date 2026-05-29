data "vault_policy_document" "all" {
  rule {
    path         = "*"
    capabilities = ["sudo", "create", "read", "update", "delete", "list"]
    description  = "allow all on secrets"
  }
}

data "vault_policy_document" "readonly" {
  rule {
    path         = "*"
    capabilities = ["read"]
    description  = "allow readonly on secrets"
  }
  rule {
    path         = "auth/token/create"
    capabilities = ["update"]
    description  = "allow creation of child tokens"
  }
}

data "vault_policy_document" "approle_auth" {
  rule {
    path         = "auth/approle/role/*"
    capabilities = ["create", "update", "read", "list"]
    description  = "Create and Update approle"
  }
}

data "vault_policy_document" "approle_restart" {
  rule {
    path         = "auth/approle/role/+/secret*"
    capabilities = ["create", "update", "read"]
    description  = "Create and Update approle"
  }
}

data "vault_policy_document" "pki" {
  rule {
    path         = "pki_int/issue/0lzi-dot-internal-com"
    capabilities = ["create", "update", ]
    description  = "Create and update Certificates"
  }
}
resource "vault_policy" "all" {
  name   = "all"
  policy = data.vault_policy_document.all.hcl
}

resource "vault_policy" "readonly" {
  name   = "read-only"
  policy = data.vault_policy_document.readonly.hcl
}

resource "vault_policy" "approle-auth" {
  name   = "approle-auth"
  policy = data.vault_policy_document.approle_auth.hcl
}

resource "vault_policy" "approle-restart" {
  name   = "approle-restart"
  policy = data.vault_policy_document.approle_restart.hcl
}

resource "vault_policy" "pki-cert" {
  name   = "pki-cert"
  policy = data.vault_policy_document.pki.hcl
}

resource "vault_jwt_auth_backend_role" "gitlab-jwt" {
  backend         = vault_jwt_auth_backend.jwt_gitlab.path
  role_name       = "read-only"
  token_policies  = ["default", "read-only", "approle-restart"]
  bound_audiences = ["https://vault.0lzi.com"]
  user_claim      = "user_email"
  token_ttl       = "3600"
  role_type       = "jwt"
  bound_claims = {
    project_id = "2,6"
    ref_type   = "branch"
  }
}


