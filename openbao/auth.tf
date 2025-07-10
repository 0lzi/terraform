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
