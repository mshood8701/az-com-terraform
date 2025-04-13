resource "azurerm_linux_virtual_machine" "webappvm" {
  name                            = "webappvm"
  resource_group_name             = azurerm_resource_group.webrgs.name
  location                        = azurerm_resource_group.webrgs.location
  size                            = "Standard_B2s"
  admin_username                  = "dev-1"
  disable_password_authentication = true
  admin_ssh_key {
    username       = "dev-1"
    public_key     = file("/Users/shood/Downloads/web-key.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.webvm_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "webvm_nic" {
  name                = "webvm_nic"
  location            = azurerm_resource_group.webrgs.location
  resource_group_name = azurerm_resource_group.webrgs.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.webpublic_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webstatic_public_ip.id
  }
  depends_on = [azurerm_network_security_group.webvm_ssh_nsg, azurerm_public_ip.webstatic_public_ip]
}

resource "azurerm_public_ip" "webstatic_public_ip" {
  name                = "webstatic_public_ip"
  resource_group_name = azurerm_resource_group.webrgs.name
  location            = azurerm_resource_group.webrgs.location
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "webvm_ssh_nsg" {
  name                = "webvm_ssh_nsg"
  location            = azurerm_resource_group.webrgs.location
  resource_group_name = azurerm_resource_group.webrgs.name

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

  tags = {
    environment = "Iac"
  }
}

#Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "webvm_nsg_nic_association" {
  network_interface_id      = azurerm_network_interface.webvm_nic.id
  network_security_group_id = azurerm_network_security_group.webvm_ssh_nsg.id
  depends_on = [azurerm_network_interface.webvm_nic] 
}
