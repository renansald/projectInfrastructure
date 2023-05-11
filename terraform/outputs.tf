output "resource_group_id"{
    value       = module.rg.resource_group_id
    description = "Resource group id"
}

output "administrator_login" {
    value       = module.mysql_server.user_name
    description = "Database user"
}

output "administrator_login_password"{
    value       = module.mysql_server.password
    description = "Database password"
}