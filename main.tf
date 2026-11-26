resource "azurerm_windows_virtual_machine" "res-1" {
  admin_password        = "Ignored-As-Imported-1"
  admin_username        = "testuser"
  location              = "southafricanorth"
  name                  = "my-test-vm-1"
  network_interface_ids = [azurerm_network_interface.res-1.id]
  reboot_setting        = "IfRequired"
  resource_group_name   = "my_test_RG"
  secure_boot_enabled   = true
  size                  = "Standard_B2as_v2"
  vtpm_enabled          = true
  zone                  = "1"
  additional_capabilities {
  }
  boot_diagnostics {
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2025-datacenter-azure-edition"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "res-1" {
  location            = "southafricanorth"
  name                = "my-test-vm-1586"
  resource_group_name = "my_test_RG"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.res-1.id
    subnet_id                     = azurerm_subnet.res-2.id
  }
}
resource "azurerm_network_interface_security_group_association" "res-1" {
  network_interface_id      = azurerm_network_interface.res-1.id
  network_security_group_id = azurerm_network_security_group.res-1.id
}
resource "azurerm_network_security_group" "res-1" {
  location            = "southafricanorth"
  name                = "my-test-vm-1-nsg"
  resource_group_name = "my_test_RG"
}
resource "azurerm_network_security_rule" "res-1" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "my-test-vm-1-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "my_test_RG"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-1,
  ]
}
resource "azurerm_public_ip" "res-1" {
  allocation_method   = "Static"
  location            = "southafricanorth"
  name                = "my-test-vm-1-ip"
  resource_group_name = "my_test_RG"
  zones               = ["1"]
}
resource "azurerm_virtual_network" "res-1" {
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  name                = "my_test_Vnet_"
  resource_group_name = "my_test_RG"
}
resource "azurerm_subnet" "res-1" {
  address_prefixes                = ["10.0.0.0/24"]
  default_outbound_access_enabled = false
  name                            = "my_test_subnet"
  resource_group_name             = "my_test_RG"
  virtual_network_name            = "my_test_Vnet_"
  depends_on = [
    azurerm_virtual_network.res-1,
  ]
}
resource "azurerm_virtual_network" "res-2" {
  address_space       = ["172.16.0.0/16"]
  location            = "southafricanorth"
  name                = "vnet-southafricanorth-1"
  resource_group_name = "my_test_RG"
  tags = {
          ManagedBy   = "Terraform"
          Environment = "Lab"
}
}
resource "azurerm_subnet" "res-2" {
  address_prefixes     = ["172.16.0.0/24"]
  name                 = "snet-southafricanorth-1"
  resource_group_name  = "my_test_RG"
  virtual_network_name = "vnet-southafricanorth-1"
  depends_on = [
    azurerm_virtual_network.res-2,
  ]
}
