variable "CONTAINER_NAME" {}
variable "RESOURCE_GROUP_NAME" {}
variable "STORAGE_ACCOUNT_NAME" {}
variable "KEY" {}

locals {
  env         = "dev"
  responsable = "Renan Saldanha"
  region      = "East US"
  rg_name     = "terraform"

}

module "rg" {
    source                       = "git::ssh://git@ssh.dev.azure.com/v3/renanlinhares01/terraform/terraform//Azure/rg-module"

    env                          = local.env
    responsable                  = local.responsable
    region                       = local.region
    rg_name                      = local.rg_name
    BACKEND_CONTAINER_NAME       = "${var.CONTAINER_NAME}"
    BACKEND_RESOURCE_GROUP_NAME  = "${var.RESOURCE_GROUP_NAME}"
    BACKEND_STORAGE_ACCOUNT_NAME = "${var.STORAGE_ACCOUNT_NAME}"
    BACKEND_KEY                  = "${var.KEY}"
}