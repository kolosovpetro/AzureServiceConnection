variable "resource_group_location" {
  type        = string
  description = "Resource group location"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine."
}

variable "storage_image_reference_publisher" {
  type        = string
  description = "The publisher of the image used to create the virtual machine."
}

variable "storage_image_reference_offer" {
  type        = string
  description = "Specifies the offer of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_image_reference_sku" {
  type        = string
  description = "Specifies the SKU of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_image_reference_version" {
  type        = string
  description = "Specifies the version of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_os_disk_caching" {
  type        = string
  description = "Specifies the caching requirements for the OS disk."
}

variable "storage_os_disk_create_option" {
  type        = string
  description = "Specifies how the virtual machine should be created."
}

variable "storage_os_disk_managed_disk_type" {
  type        = string
  description = "Specifies the storage account type for the managed disk."
}

variable "os_profile_admin_username" {
  type        = string
  description = "Specifies the name of the administrator account."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}


variable "tags" {
  type        = map(string)
  description = "Tags for all resources"
  default = {
    Environment  = "DEV"
    Owner        = "Terraform"
    Autoshutdown = "OFF"
  }
}