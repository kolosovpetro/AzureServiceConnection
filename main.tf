resource "azurerm_resource_group" "public" {
  name     = "rg-service-endpoint-${var.prefix}"
  location = var.resource_group_location
  tags     = var.tags
}

#################################################################################################################
# NETWORK
#################################################################################################################

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.prefix}"
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name
  address_space       = ["10.10.0.0/24"]
}
resource "azurerm_subnet" "subnet_vm" {
  name                 = "subnet-vm-${var.prefix}"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.public.name
  address_prefixes     = ["10.10.0.0/25"]
  service_endpoints    = ["Microsoft.Storage"]
}

#################################################################################################################
# STORAGE ACCOUNT
#################################################################################################################

resource "azurerm_storage_account" "storage" {
  name                     = "storageacctsvcendpt"
  resource_group_name      = azurerm_resource_group.public.name
  location                 = azurerm_resource_group.public.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.subnet_vm.id] # Allow access via Service Endpoint
    bypass                     = ["AzureServices"]             # Allow access from Azure services if needed
  }
}

#################################################################################################################
# VIRTUAL MACHINE UBUNTU
#################################################################################################################

module "linux_vm" {
  source                            = "./modules/azure-linux-vm-key-auth"
  ip_configuration_name             = "ipc-vm-${var.prefix}"
  network_interface_name            = "nic-vm-${var.prefix}"
  os_profile_admin_public_key_path  = "${path.root}/id_rsa.pub"
  os_profile_admin_username         = var.os_profile_admin_username
  os_profile_computer_name          = "vm-${var.prefix}"
  resource_group_location           = azurerm_resource_group.public.location
  resource_group_name               = azurerm_resource_group.public.name
  storage_image_reference_offer     = var.storage_image_reference_offer
  storage_image_reference_publisher = var.storage_image_reference_publisher
  storage_image_reference_sku       = var.storage_image_reference_sku
  storage_image_reference_version   = var.storage_image_reference_version
  storage_os_disk_caching           = var.storage_os_disk_caching
  storage_os_disk_create_option     = var.storage_os_disk_create_option
  storage_os_disk_managed_disk_type = var.storage_os_disk_managed_disk_type
  storage_os_disk_name              = "osdisk-vm-${var.prefix}"
  vm_name                           = "vm-vm-${var.prefix}"
  vm_size                           = var.vm_size
  public_ip_name                    = "pip-vm-${var.prefix}"
  subnet_id                         = azurerm_subnet.subnet_vm.id
  network_security_group_id         = azurerm_network_security_group.public.id
}


