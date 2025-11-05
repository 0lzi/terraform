resource "vault_auth_backend" "userpass" {
  type = "userpass"
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
  path  = "jwt"
  oidc_discovery_url ="https://gitlab.0lzi.com"
  bound_issuer = "https://gitlab.0lzi.com"
  description = "JWT Auth for Gitlab"
}
