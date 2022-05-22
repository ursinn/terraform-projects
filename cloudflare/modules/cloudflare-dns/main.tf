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

resource "cloudflare_record" "dns_srv" {
  zone_id  = var.zone_id
  for_each = var.dns_srv
  name     = each.value.name
  type     = each.value.type
  proxied  = each.value.proxied
  data {
    service  = each.value.data.service
    proto    = each.value.data.proto
    name     = each.value.data.name
    priority = each.value.data.priority
    weight   = each.value.data.weight
    port     = each.value.data.port
    target   = each.value.data.target
  }
}
