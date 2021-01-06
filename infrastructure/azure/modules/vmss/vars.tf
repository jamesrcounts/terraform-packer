variable "disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to encrypt the OS Disk."
}

variable "project" {
  type        = string
  description = "The project id to use when generating names, etc."
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })

  description = "The resource group in which to create module resources."
}

variable "source_image_id" {
  type        = string
  default     = ""
  description = "The VM Image to base the scale set on."
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  default = null

  description = "(optional) Specifies a marketplace image to base instances on"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet which the IP Configuration should be connected to."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to every resource."
}

variable "log_analytics_workspace" {
  type = object({
    workspace_id       = string
    primary_shared_key = string
  })

  description = "The log analtyics workspace which VM Insights should be connected to."
}