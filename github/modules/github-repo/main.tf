terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

# Repo Settings
resource "github_repository" "repo" {
  for_each                                = var.repos
  name                                    = each.key
  description                             = each.value.description
  homepage_url                            = each.value.homepage_url
  visibility                              = each.value.visibility
  has_issues                              = each.value.has_issues != null ? each.value.has_issues : true
  has_projects                            = each.value.has_projects != null ? each.value.has_projects : false
  has_wiki                                = each.value.has_wiki != null ? each.value.has_wiki : false
  is_template                             = each.value.is_template != null ? each.value.is_template : false
  allow_merge_commit                      = each.value.allow_merge_commit != null ? each.value.allow_merge_commit : true
  allow_squash_merge                      = each.value.allow_squash_merge != null ? each.value.allow_squash_merge : true
  allow_rebase_merge                      = each.value.allow_rebase_merge != null ? each.value.allow_rebase_merge : true
  allow_auto_merge                        = each.value.allow_auto_merge != null ? each.value.allow_auto_merge : false
  delete_branch_on_merge                  = each.value.delete_branch_on_merge != null ? each.value.delete_branch_on_merge : false
  has_downloads                           = true
  auto_init                               = each.value.auto_init != null ? each.value.auto_init : false
  gitignore_template                      = each.value.gitignore_template
  license_template                        = each.value.license_template
  archive_on_destroy                      = each.value.archive_on_destroy != null ? each.value.archive_on_destroy : true
  topics                                  = each.value.topics
  vulnerability_alerts                    = each.value.vulnerability_alerts != null ? each.value.vulnerability_alerts : true
  ignore_vulnerability_alerts_during_read = each.value.ignore_vulnerability_alerts_during_read == null ? each.value.ignore_vulnerability_alerts_during_read : true
}

# Repo Branches
resource "github_branch" "branch" {
  for_each = var.branches
  repository = each.key
  branch = each.value.branch
  source_branch = each.value.source_branch
  source_sha = each.value.source_sha
}

# Repo Default Branch
resource "github_branch_default" "default"{
  for_each = var.repos
  repository = each.key
  branch     = each.value.default_branch
}