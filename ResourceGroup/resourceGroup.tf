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
    source               = "git::ssh://renanlinhares01@dev.azure.com/renanlinhares01/terraform/_git/terraform"

    env                  = local.env
    responsable          = local.responsable
    region               = local.region
    rg_name              = local.rg_name
    CONTAINER_NAME       = "${var.CONTAINER_NAME}"
    RESOURCE_GROUP_NAME  = "${var.RESOURCE_GROUP_NAME}"
    STORAGE_ACCOUNT_NAME = "${var.STORAGE_ACCOUNT_NAME}"
    KEY                  = "${var.KEY}"
}