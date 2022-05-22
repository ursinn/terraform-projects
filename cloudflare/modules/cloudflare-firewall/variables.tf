variable "zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "firewall" {
  description = "Firewall Settings"
  type = map(object({
    description = string
    expression  = string
    action      = string
    priority    = number
  }))
}
