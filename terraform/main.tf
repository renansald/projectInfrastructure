variable "CONTAINER_NAME" {}
variable "RESOURCE_GROUP_NAME" {}
variable "STORAGE_ACCOUNT_NAME" {}
variable "KEY" {}

locals {
  env         = "dev"
  responsable = "Renan Saldanha"
  region      = "East US"
  rg_name     = "terraform"
  BACKEND_CONTAINER_NAME       = "${var.CONTAINER_NAME}"
  BACKEND_RESOURCE_GROUP_NAME  = "${var.RESOURCE_GROUP_NAME}"
  BACKEND_STORAGE_ACCOUNT_NAME = "${var.STORAGE_ACCOUNT_NAME}"
  BACKEND_KEY                  = "${var.KEY}"
}


# RESOURCE_GROUP


module "rg" {
    source      = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/rg-module"

    env         = local.env
    responsable = local.responsable
    region      = local.region
    rg_name     = local.rg_name
}

#DATABASE

resource "random_string" "admin" {
  length  = 8
  special = false
}

resource "random_string" "password" {
  length  = 16
  special = true
}

module "mysql_server" {
    source                        = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/mysqlserver" 
    env                           = local.env
    responsable                   = local.responsable
    name                          = "application"
    location                      = module.rg.region
    resource_group_name           = module.rg.rg_name
    sku_name                      = "B_Gen5_1"
    version_server                = "8.0"
    administrator_login           = random_string.admin.result
    administrator_login_password  = random_string.password.result
    public_network_access_enabled = true
    instance = 1
}

module "mysql_db" {
    source              = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/mysql"
    env                 = local.env
    name                = "db_application"
    server_name         = module.mysql_server.name
    resource_group_name = module.rg.rg_name
}

module "mysql_firewall" {
  source              = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/mysql_firewall"
  rule_name           = "allow-all"
  resource_group_name = module.rg.rg_name
  server_name         = module.mysql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

provider "mysql" {
  endpoint = "${module.mysql_server.fqnd}:3306"
  username = "${module.mysql_server.user_name}@${module.mysql_server.name}"
  password = module.mysql_server.password
  tls      = true
}

resource "random_password" "database_password" {
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}
resource "random_string" "username" {
  length           = 5
  special          = false
  override_special = "/@£$"
}

resource "mysql_user" "db_user" {
  user               = random_string.user_name.result
  host               = "%"
  plaintext_password = random_string.database_password.result
}

resource "mysql_grant" "user_access" {
  user       = mysql_user.db_user.user
  host       = mysql_user.db_user.host
  database   = var.database_name
  privileges = ["SELECT", "UPDATE", "DELETE", "EXECUTE", "INSERT"]
}