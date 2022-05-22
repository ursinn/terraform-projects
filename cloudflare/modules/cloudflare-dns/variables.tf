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
