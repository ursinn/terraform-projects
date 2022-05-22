terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

# Account Settings
# resource "cloudflare_zone_settings_override" "settings" {
#   for_each = var.cloudflare_zones
#   zone_id  = each.value.zone_id
#   settings {
#     # On/Off Values
#     always_online               = "on" # Tells Cloudflare to serve my site with a cached version if down
#     always_use_https            = "on" # Always use https over http
#     automatic_https_rewrites    = "on" # Automatically rewrite http to https
#     binary_ast                  = "off"
#     brotli                      = "on"  # Utilize brotli compression
#     browser_check               = "on"  # Check that browsers are valid and stop others
#     development_mode            = "off" # Development mode disables all caching
#     early_hints                 = "on"
#     email_obfuscation           = "on" # Hide email addresses from bots/harvesters
#     filter_logs_to_cloudflare   = "off"
#     hotlink_protection          = "on" # Protect images from off-site linking
#     #http2                       = "on" # Enable HTTP2
#     http3                       = "on" # Enable HTTP3
#     ip_geolocation              = "on" # Enable GeoLocation tagging of visitors
#     ipv6                        = "on" # Enable IPv6
#     #mirage                      = "off"
#     opportunistic_encryption    = "on" # Opportunistic Encryption for HTTP/2 etc.
#     opportunistic_onion         = "on" # Allow legitimate users to route through Cloudflare's Onion IPs
#     orange_to_orange            = "off"
#     origin_error_page_pass_thru = "off"
#     #prefetch_preload            = "off"
#     privacy_pass                = "on"
#     #response_buffering          = "off"
#     rocket_loader               = "on"
#     server_side_exclude         = "on"
#     #sort_query_string_for_cache = "off"
#     tls_client_auth             = "on"
#     true_client_ip_header       = "off"
#     universal_ssl               = "on"
#     waf                         = "off"
#     websockets                  = "off"
#     zero_rtt                    = "on"
#     # String Values
#     cache_level        = "aggressive" # Caching Level to use -- options are  "aggressive", "basic", "simplified"
#     cname_flattening   = "flatten_at_root"
#     h2_prioritization  = "off"
#     #image_resizing     = "off"
#     min_tls_version    = "1.2" # Minimum version of TLS available to connect to sites
#     #polish             = "off"
#     #proxy_read_timeout = "100"
#     pseudo_ipv4        = "off"
#     security_level     = "medium" # Security level for attack protections
#     ssl                = "strict" # SSL Enforcement level
#     tls_1_3            = "zrt"    # TLS 1.3 -- options "on", "off", "zrt"
#     # Integer Values
#     browser_cache_ttl = 14400 # Cache TTL in seconds
#     challenge_ttl     = 1800  # TTL for Challenges
#     max_upload        = 100   # Maximum upload size
#     # Nested Objects
#     minify {
#       css  = "on"
#       js   = "on"
#       html = "on"
#     }
#     security_header {
#       enabled            = true
#       preload            = true
#       max_age            = 31536000
#       include_subdomains = true
#       nosniff            = true
#     }
#   }
# }

# DNS Records
module "cloudflare-dns" {
  source = "./modules/cloudflare-dns"

  for_each = var.cloudflare_zones
  zone_id  = each.value.zone_id
  dns      = each.value.dns
  dns_srv  = each.value.dns_srv != null ? each.value.dns_srv : {}
}

# Firewall Settings
module "cloudflare-firewall" {
  source = "./modules/cloudflare-firewall"

  for_each = var.cloudflare_zones
  zone_id  = each.value.zone_id
  firewall = each.value.firewall
}
