variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "dns" {
  description = "DNS Record"
  type = map(object({
    name     = string
    value    = string
    type     = string
    proxied  = optional(bool)
    priority = optional(number)
  }))
}

variable "dns_srv" {
  description = "DNS Record"
  type = map(object({
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
  }))
}
