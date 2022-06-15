# generic animal name decoration
resource "random_pet" "name" {
  prefix = var.prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.name.id
  location = var.location
  tags = {
    environment = "development"
    stage       = "load balance weight group"
  }
}

#############################################################################
# VIRTUAL NETWORKS
#############################################################################

resource "azurerm_virtual_network" "weight_app_network" {
  name                = "${var.prefix}_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

## PUBLIC subnet:
resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontendSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name
  address_prefixes     = ["10.0.10.0/24"]
}

# PUBLIC IP
resource "azurerm_public_ip" "frontend_public_ip" {
  name                = "weight_app_public_ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}
# PUBLIC Network Security Group and rule
resource "azurerm_network_security_group" "public_nsg" {
  name                = "FrontEndSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 901
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# connect public nic to nsg fix to dry
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc0" {
  network_interface_id      = azurerm_network_interface.network_interface_app[0].id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc1" {
  network_interface_id      = azurerm_network_interface.network_interface_app[1].id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}
resource "azurerm_network_interface_security_group_association" "fe_nsg_assoc2" {
  network_interface_id      = azurerm_network_interface.network_interface_app[2].id
  network_security_group_id = azurerm_network_security_group.public_nsg.id
}
## PRIVATE subnet:
resource "azurerm_subnet" "backend_subnet" {
  name                 = "privatenet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.weight_app_network.name
  address_prefixes     = ["10.0.0.0/24"]
}
#  PRIVATE Network Security Group and rule
resource "azurerm_network_security_group" "backend_subnet" {
  name                = "bENetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Postgresql"
    priority                   = 901
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# connect be nic to nsg
resource "azurerm_network_interface_security_group_association" "be_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.network_interface_db[0].id
  network_security_group_id = azurerm_network_security_group.backend_subnet.id
}

#############################################################################
# LOAD BALANCER
#############################################################################

resource "azurerm_lb" "azurerm_lb" {
  name                = "loadbalance1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # retrieve frunt end ip from machine
  frontend_ip_configuration {
    name                 = "frontend_ip"
    public_ip_address_id = azurerm_public_ip.frontend_public_ip.id
  }
}

# Load balancer rules

resource "azurerm_lb_rule" "azurerm_lb_rule" {
  resource_group_name            = random_pet.name.id
  loadbalancer_id                = azurerm_lb.azurerm_lb.id
  name                           = "lb-rule-http"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = azurerm_lb.azurerm_lb.frontend_ip_configuration[0].name

  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.azurerm_lb.id
  name            = "BackEndAddressPool"
}

#############################################################################
# LOAD BALANCED NETWORK INTERFACE
#############################################################################

resource "azurerm_network_interface" "network_interface_app" {
  count               = "3"
  name                = "${var.prefix}NC${count.index}"
  resource_group_name = random_pet.name.id
  location            = var.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "network_interface_db" {
  count               = "1"
  name                = "postgres_network_interface"
  resource_group_name = random_pet.name.id
  location            = var.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.backend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}



resource "azurerm_availability_set" "avset" {
  name                         = "${var.prefix}availabilitySet"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rg.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3
  managed                      = true
}

#############################################################################
# VIRTUAL MACHINE
#############################################################################

resource "azurerm_linux_virtual_machine" "postgresMachine" {

  name                = "postgresMachine"
  resource_group_name = random_pet.name.id
  location            = var.location
  size                = "Standard_b1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  #  availability_set_id             = azurerm_availability_set.avset.id
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.network_interface_db[0].id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

# application virtual machine
resource "azurerm_linux_virtual_machine" "frontendServer" {
  count = "3"

  name                            = "frontendMachine${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  disable_password_authentication = false
  #  size                = "Standard_F2"
  size                  = "Standard_b1s"
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  availability_set_id   = azurerm_availability_set.avset.id
  network_interface_ids = [element(azurerm_network_interface.network_interface_app.*.id, count.index)]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  #	provisioner "file" {
  #        source = "example_file.txt"
  #        destination = "/tmp/example_file.txt"
  #    }
  tags = {
    environment = "staging"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /var/www ; cd /var/www",
      "git clone https://github.com/johnmogi/bootcamp-app.git",
      "sudo chmod +x ./frontend.sh; ./frontend.sh"
    ]
  }

}
