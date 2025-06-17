resource "google_iam_workload_identity_pool" "github_ci" {
  workload_identity_pool_id = "github-ci"
  description               = "Workload Identity Pool for CI/CD"
}

resource "google_iam_workload_identity_pool_provider" "github_ci" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_ci.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-ci"
  attribute_mapping = {
    "google.subject"             = "assertion.sub",
    "attribute.actor"            = "assertion.actor",
    "attribute.aud"              = "assertion.aud",
    "attribute.repository"       = "assertion.repository",
    "attribute.repository_owner" = "assertion.repository_owner",
    "attribute.ref"              = "assertion.ref",
  }

  # Only allow authentication for main branch
  attribute_condition = "assertion.ref=='refs/heads/main'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}