variable "name" {
  description = "Specify the name of the server"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.name) > 0
    error_message = "The server must have a name"
  }
}

variable "resource_group_name" {
  description = "The name of resource group where will be create the server"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.resource_group_name) > 0 && regex(" ", var.resource_group_name)
    error_message = "The resource group name must be a valid name"
  }
}

variable "location" {
  description = "Location where your resource is deployed"
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.location) > 0
    error_message = "location must be a valid location"
  }
}

variable "sku_name" {
  description = "Specify the SKU name for mysql server"
  type        = string
  validation {
    condition     = contains(var.sku_name, ["B_Gen4_1", "B_Gen4_2", "B_Gen5_1", "B_Gen5_2", 
                    "GP_Gen4_2", "GP_Gen4_4", "GP_Gen4_8", "GP_Gen4_16", "GP_Gen4_32", "GP_Gen5_2", 
                    "GP_Gen5_4", "GP_Gen5_8", "GP_Gen5_16", "GP_Gen5_32", "GP_Gen5_64", "MO_Gen5_2", 
                    "MO_Gen5_4", "MO_Gen5_8", "MO_Gen5_16", "MO_Gen5_32"])
    error_message = "Invalid SKU name"
  }
}

variable "version" {
  description = "the verison of the mysql"
  type        = string
  default     = "8.0"
  validation {
    condition     = contains(var.version, ["8.0", "5.7"])
    error_message = "Invalid mysql version"
  }
}

variable "create_mode" {
  description = "The creation mode"
  type        = string
  default     = "Default"
  validation {
    condition     = contains(var.create_mode, ["Default", "Replica", "GeoRestore", "PointInTimeRestore"])
    error_message = "Invalid creation mode"
  }
}

variable "administration_login" {
  description = "The administration login for MySql server"
  type        = string
  validation {
    condition     = var.create_mode == "Default" ? var.administration_login.length > 0 : null
    error_message = "When you are create a mysql server in default you must have a administration login"
  }
}

variable "administration_login_password" {
  description = "The administration password for MySql server"
  type        = string
  validation {
    condition     = var.create_mode == "Default" ? var.administration_login_password.length > 0 : null
    error_message = "When you are create a mysql server in default you must have a administration login"
  }
}

variable "auto_grow_enabled" {
  description = "Enable ou disable the auto-growing of the storage"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Define the retention days of the server"
  type        = number
  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <=35
    error_message = "The retention days must be between 7 and 35 days"
  }
}

variable "creation_source_server_id" {
  description = "Define the sourcer server wiil be used when the creation mode is different of Default"
  type        = string
  validation {
    condition     = var.creation_source_server_id.length > 0
    error_message = "The server source id must be a valid id"
  }
}

variable "infrastructure_encryption_enabled" {
  description = "Whether or not infrastructure is encrypted for this server. Changing this forces a new resource to be created"
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Define if public network is allowed to access the server"
  type        = bool
  default     = false
}

variable "restore_point_in_time" {
  description = "Specifies the point in time to restore from source server"
  type        = string
  validation {
    condition     = regex("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z$")
    error_message = "Invalid restore point"
  }
}

variable "ssl_enforcement_enabled" {
  description = "Define if SSL will be enable or not"
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "Define the TLS version will be use"
  type        = string
  default     = "TLS1_2"
  validation {
    condition = contains(var.ssl_minimal_tls_version_enforced, ["TLSEnforcementDisabled", "TLS1_0", "TLS1_1", "TLS1_2"])
  }
}

variable "storage_mb" {
  description = "Max storage will be allowed to the server"
  type        = number
}

variable "threat_detection_policy" {
  description = "Threat detection policy configuration, known in the API as Server Security Alerts Policy."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the server"
  type        = map
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