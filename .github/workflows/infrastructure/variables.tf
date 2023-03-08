variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}
variable "resource_location" {
  type        = string
  description = "Location of resources"
  default     = "East US"
}

variable "resource_base_name" {
  type        = string
  description = "Base name for resources"
  default     = "learn-git-actions"
}

variable "resource_suffix" {
  type        = string
  description = "Unique suffix for resources identification"
  default     = "01"
}
