module "secrets_manager" {
  source  = "tedilabs/secret/aws//modules/secrets-manager-secret"
  version = "0.3.0"

  for_each = {
    for index, secret in var.managed_secrets:
      secret.name => secret #use secret.name as the resource index
  }

  name                    = each.value.name
  description             = lookup(each.value, "description",             null)
  deletion_window_in_days = lookup(each.value, "deletion_window_in_days", null)
  type                    = lookup(each.value, "type",                    "KEY_VALUE")
  value                   = lookup(each.value, "value",                   null)
  module_tags_enabled     = lookup(each.value, "module_tags_enabled",     false)
  resource_group_enabled  = lookup(each.value, "resource_group_enabled",  false)
  resource_group_name     = lookup(each.value, "resource_group_name",     false)
  kms_key                 = lookup(each.value, "kms_key",                 null)

  tags = {
    Name = replace("secret-${each.value.name}", "/", "-") #replace slashes with dashes
  }
}
