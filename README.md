## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.56.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_availability_set.avset](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/availability_set) | resource |
| [azurerm_lb.azurerm_lb](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_pool](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_rule.azurerm_lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine.frontendServer](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.postgresMachine](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.network_interface_app](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.network_interface_db](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.be_nsg_assoc](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc0](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc1](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.fe_nsg_assoc2](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.backend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.public_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.frontend_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.backend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/subnet) | resource |
| [azurerm_subnet.frontend_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.weight_app_network](https://registry.terraform.io/providers/hashicorp/azurerm/2.56.0/docs/resources/virtual_network) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | frontend admin password | `string` | `"P@$$w0rd1234!"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | frontend admin user name | `string` | `"adminuser"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the resource group. | `string` | `"eastus"` | no |
| <a name="input_machines_number"></a> [machines\_number](#input\_machines\_number) | n/a | `number` | `3` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | weight app prefix | `string` | `"weight_app"` | no |
| <a name="input_rg_main"></a> [rg\_main](#input\_rg\_main) | n/a | `string` | `"weight_app_group"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_password"></a> [password](#output\_password) | output "username" { value = admin\_username } |
