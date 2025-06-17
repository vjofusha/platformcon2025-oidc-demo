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

data "google_iam_policy" "sa_user" {
  binding {
    role = "roles/iam.workloadIdentityUser"

    members = [
      "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_ci.name}/attribute.ref/refs/heads/main"
    ]
  }
}

resource "google_service_account" "demo" {
  account_id   = "github-actions-demo"
  display_name = "Github Actions Demo"
  description  = "Service account used in Github Actions Workflows"
  project      = local.project_id
}

resource "google_service_account_iam_policy" "demo" {
  service_account_id = google_service_account.demo.id
  policy_data        = data.google_iam_policy.sa_user.policy_data
}
