variable "cloudflare_token" {
  type = string
}

variable "cloudflare_zones" {
  type = map(object({
    zone_id = string
    firewall = map(object({
      description = string
      expression  = string
      action      = string
      priority    = number
    }))
    dns = map(object({
      name     = string
      value    = string
      type     = string
      proxied  = optional(bool)
      priority = optional(number)
    }))
    dns_srv = optional(map(object({
      name    = string
      type    = string
      proxied = optional(bool)
      data = object({
        service  = string
        proto    = string
        name     = string
        priority = number
        weight   = number
        port     = number
        target   = string
      })
    })))
  }))
}
