variable "usernames" {
  description = "List of usernames for generating service accounts"
  type        = list(string)
}

resource "google_service_account" "service_accounts" {
  count        = length(var.usernames)
  account_id   = var.usernames[count.index]
  display_name = "${var.usernames[count.index]} Service Account"
}

# IAM Policy Binding for Roles
resource "google_project_iam_member" "logging_viewer" {
  for_each = toset(var.usernames)

  project = var.project_id  
  role    = "roles/logging.viewer"
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
}

resource "google_project_iam_member" "logging_view_accessor" {
  for_each = toset(var.usernames)

  project = var.project_id  
  role    = "roles/logging.viewAccessor"
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
}

resource "google_project_iam_member" "bigquery_admin" {
  for_each = toset(var.usernames)

  project = var.project_id  
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"
}
