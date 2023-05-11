resource "azurerm_mysql_database" "mysql" {
  name           = join("-", ["mysql", var.name, var.env])
  server_name      = var.server_name
  resource_group_name = var.resource_group_name
  charset = var.charset
  collation = var.collation
  tags           = merge(var.tag, {
    responsable = var.responsable,
    environment = var.env
  })
}