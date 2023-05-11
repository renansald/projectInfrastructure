output "resource_group_id"{
    value       = module.rg.resource_group_id
    description = "Resource group id"
}

output "administration_login" {
    value       = module.mysql_server.administration_login
    description = "Database user"
}

output "administration_login_password"{
    value       = module.mysql_server.administration_login_password
    description = "Database password"
}