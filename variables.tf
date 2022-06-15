variable "machines_number" {
  default = 3
}
variable "rg_main" {
  default = "weight_app_group"
}
variable "location" {
  type = string
  default = "eastus"
  description   = "Location of the resource group."
}
# prefix resources association tool
variable "prefix" {
  type        = string
  default = "weight_app"
  description   = "weight app prefix"
}


# there must be a way to hide these:
variable "admin_username" {
  type        = string
  default = "adminuser"
  description   = "frontend admin user name"
}
variable "admin_password" {
  type        = string
  default = "P@$$w0rd1234!"
  description   = "frontend admin password"
}
