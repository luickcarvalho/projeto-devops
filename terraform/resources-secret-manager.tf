module "secret_comment" {
  source  = "tedilabs/secret/aws//modules/secrets-manager-secret"
  version = "0.3.0"

  name                   = var.secrets.name
  description            = var.secrets.description
  type                   = var.secrets.type
  value                  = var.secrets.value
  module_tags_enabled    = false
  resource_group_enabled = false
  resource_group_name    = false

  tags = {
    Name = var.secrets.name
  }
}