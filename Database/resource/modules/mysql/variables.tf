variable "name" {
  description = "Database name"
  type        = string
  validation {
    condition     = var.name.length > 0
    error_message = "The database must have a name"
  }
}

variable "server_name" {
  description = "Server name where database will be create"
  type        = string
}

variable "tag" {
  description = "Project tags to indentifier resource"
  type        = map
}

variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "charset" {
  description = "This variable specify the mysql charset"
  type        = string
  default     = "utf8"
}

variable "collation" {
  description = "This variable specify the colletions for mysql"
  type        = string
  default     = "utf8_unicode_ci"
}

variable "BACKEND_RESOURCE_GROUP_NAME" {
  description = "Provider resource group"
  type        = string
}

variable "BACKEND_STORAGE_ACCOUNT_NAME" {
  description = "provider storage account where save the tf state"
  type        = string
}

variable "BACKEND_CONTAINER_NAME" {
  description = "container name"
  type        = string
}

variable "BACKEND_KEY" {
  description = "name of tf state file"
  type        = string
  default     = "state.terraform.tfstate"
}

variable "env" {
  description = "descript the environment"
  type        = string
  validation{
    condition     = var.env.length > 0
    error_message = "The enviroment can't be a empty value"
  }
}

variable "responsable" {
  description = "Resources's responsable"
  type        = string
}

variable "instance" {
  description = "Resource instance"
  type        = number 
}