output "resource_group_id"{
    value       = module.rg.resource_group_id
    description = "Resource group id"
}

output "administrator_login" {
    value       = module.mysql_server.user_name
    description = "Database user"
}

output "administrator_login_password"{
    value       = random_string.password.result
    description = "Database password"
}

output "fqdn" {
  value = module.mysql_server.fqdn
}

output "database_user"{
    value = mysql_user.db_user.user
}

output "database_password"{
    value = mysql_user.db_user.plaintext_password
}