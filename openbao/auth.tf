resource "vault_auth_backend" "userpass" {
  type        = "userpass"
  description = "Login with Username and Password"
}

resource "vault_generic_endpoint" "demo" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/demo"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["all"],
  "password": "changeme"
}
EOT
}

# JWT auth for gitlab
resource "vault_jwt_auth_backend" "jwt_gitlab" {
  path               = "jwt"
  oidc_discovery_url = "https://gitlab.0lzi.com"
  bound_issuer       = "https://gitlab.0lzi.com"
  description        = "JWT Auth for Gitlab"
}

# Approle Auth
resource "vault_auth_backend" "approle" {
  type        = "approle"
  description = "Machine Login with role_id and secret_id"
}
# BAO AGENT
resource "vault_approle_auth_backend_role" "bao_agent" {
  backend            = vault_auth_backend.approle.path
  role_name          = "approle-auth"
  token_policies     = ["default", "pki-cert", "approle-auth"]
  secret_id_num_uses = 0
}

resource "vault_approle_auth_backend_role_secret_id" "id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.bao_agent.role_name
}

# BOOTSTRAP

resource "vault_approle_auth_backend_role" "bootstrap" {
  backend        = vault_auth_backend.approle.path
  role_name      = "agent-approle-auth"
  token_policies = ["approle-restart"]
}

resource "vault_approle_auth_backend_role_secret_id" "bootstrap_id" {
  backend               = vault_auth_backend.approle.path
  role_name             = vault_approle_auth_backend_role.bootstrap.role_name
  wrapping_ttl          = "300s"
  with_wrapped_accessor = true
}
