resource "azurerm_mysql_server" "sql_server" {
  name                              = join("-", 
    ["mysqlServer", var.name, var.env, replace(var.location, " ", ""), var.instance])
  resource_group_name               = var.resource_group_name
  location                          = var.location
  sku_name                          = var.sku_name
  version                           = var.version
  create_mode                       = var.create_mode
  administration_login              = var.administration_login
  administration_login_password     = var.administration_login_password
  auto_grow_enabled                 = var.auto_grow_enabled
  backup_retention_days             = var.backup_retention_days
  creation_source_server_id         = var.creation_source_server_id
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  restore_point_in_time             = var.restore_point_in_time
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
  storage_mb                        = var.storage_mb
  threat_detection_policy           = var.threat_detection_policy
  tags                              = merge(var.tags, {
    env = var.env,
    responsable = var.responsable
  })
}