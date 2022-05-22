terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

provider "github" {
  token = var.github_token
  owner = "ursinn"
}

# Repo Settings
module "github-repo" {
  source = "./modules/github-repo"

  for_each = var.github
  repos    = each.value.repos
  branches = each.value.branches
}