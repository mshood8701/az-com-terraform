resource "azurerm_virtual_network" "webvnet" {
  name                = "webvnet"
  resource_group_name = azurerm_resource_group.webrgs.name
  location            = azurerm_resource_group.webrgs.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "webpublic_subnet" {
  name                 = "webpublic_subnet"
  resource_group_name  = azurerm_resource_group.webrgs.name
  virtual_network_name = azurerm_virtual_network.webvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_route_table" "webpublic_rt" {
  name                = "ebpublic_rt"
  location            = azurerm_resource_group.webrgs.location
  resource_group_name = azurerm_resource_group.webrgs.name

  route {
    name           = "public_internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "webpublic_subent_rt_association" {
  subnet_id      = azurerm_subnet.webpublic_subnet.id
  route_table_id = azurerm_route_table.webpublic_rt.id
} 
