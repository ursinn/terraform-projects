variable "github_token" {
  type = string
}

variable "github" {
  type = map(object({
    repos = map(object({
      description                             = optional(string)
      homepage_url                            = optional(string)
      visibility                              = string
      has_issues                              = optional(bool)
      has_projects                            = optional(bool)
      has_wiki                                = optional(bool)
      is_template                             = optional(bool)
      allow_merge_commit                      = optional(bool)
      allow_squash_merge                      = optional(bool)
      allow_rebase_merge                      = optional(bool)
      allow_auto_merge                        = optional(bool)
      delete_branch_on_merge                  = optional(bool)
      auto_init                               = optional(bool)
      gitignore_template                      = optional(string)
      license_template                        = optional(string)
      archive_on_destroy                      = optional(bool)
      topics                                  = optional(list(string))
      vulnerability_alerts                    = optional(bool)
      ignore_vulnerability_alerts_during_read = optional(bool)
      default_branch                          = string
    }))
    branches = map(object({
      branch        = string
      source_branch = optional(string)
      source_sha    = optional(string)
    }))
  }))
}