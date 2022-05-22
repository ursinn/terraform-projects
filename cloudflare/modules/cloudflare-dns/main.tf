terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

# DNS Records
resource "cloudflare_record" "dns" {
  zone_id  = var.zone_id
  for_each = var.dns
  name     = each.value.name
  value    = each.value.value
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.priority != null ? each.value.priority : null
}
