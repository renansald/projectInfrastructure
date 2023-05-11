output "server_id"{
    value       = azurerm_mysql_server.sql_server.id
    description = "mySQL server id"
}

output "user_name"{
    value = azurerm_mysql_server.sql_server.administration_login
    description = "user namer"
}

output "password"{
    value = azurerm_mysql_server.sql_server.administration_login_password
    description = "password"
}