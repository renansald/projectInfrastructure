variable "CONTAINER_NAME" {}
variable "RESOURCE_GROUP_NAME" {}
variable "STORAGE_ACCOUNT_NAME" {}
variable "KEY" {}

locals {
  env         = "dev"
  responsable = "Renan Saldanha"
}

resource "random_string" "admin" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 16
  special = true
}

module "mysql_server" {
    source                        = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform/Azure/mysqlserver"
    env                           = local.env
    responsable                   = local.responsable
    name                          = "application"
    location                      = module.rg.region
    resource_group_name           = module.rg.rg_name
    sku_name                      = "B_Gen4_1"
    version                       = "8.0"
    administration_login          = random_string.admin.result
    administration_login_password = random_string.password.result
    public_network_access_enabled = true
    instance = 1
    BACKEND_CONTAINER_NAME        = "${var.CONTAINER_NAME}"
    BACKEND_RESOURCE_GROUP_NAME   = "${var.RESOURCE_GROUP_NAME}"
    BACKEND_STORAGE_ACCOUNT_NAME  = "${var.STORAGE_ACCOUNT_NAME}"
    BACKEND_KEY                   = "${var.KEY}"
}

module "mysql_db" {
    source              = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/mysql"
    env                 = local.env
    responsable         = local.responsable
    name                = "db_application"
    server_name         = module.mysql_server.name
    resource_group_name = module.rg.rg_name
}