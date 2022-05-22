terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

# Firewall Settings
resource "cloudflare_filter" "firewall" {
  zone_id     = var.zone_id
  for_each    = var.firewall
  description = each.value.description
  expression  = each.value.expression
}
resource "cloudflare_firewall_rule" "firewall" {
  zone_id     = var.zone_id
  for_each    = var.firewall
  description = each.value.description
  filter_id   = cloudflare_filter.firewall[each.key].id
  action      = each.value.action
  priority    = each.value.priority
}
