locals {
  name = "oidc-demo"
  company = "mycompany"
}

resource "vault_jwt_auth_backend" "oidc_demo" {
  description        = "Accept OIDC authentication from GitHub Action workflows"
  path               = local.name
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend_role" "oidc_demo" {
  role_name         = local.name
  bound_claims_type = "string"
  bound_subject     = "repo:${local.company}/${local.name}:ref:refs/heads/main"

  # Required configuration attributes
  token_policies  = [vault_policy.oidc_demo.name]
  bound_audiences = ["https://github.com/${local.company}"]
  role_type       = "jwt"
  backend         = vault_jwt_auth_backend.oidc_demo.path
  user_claim      = "actor"
  token_ttl       = 300 # 5 minutes
}

data "vault_policy_document" "oidc_demo" {
  rule {
    path         = "secret/data/${local.name}"
    capabilities = ["read"]
  }
}

resource "vault_policy" "oidc_demo" {
  name   = local.name
  policy = data.vault_policy_document.oidc_demo.hcl
}
