# output "public_ip_address" {
#   value = data.azurerm_public_ip.myterraformpublicip.ip_address
# }

#output "username" {
#  value = admin_username
#}
#
output "password" {
  value = var.admin_password
  #   sensitive = true
}