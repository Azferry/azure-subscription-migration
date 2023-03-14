
variable "rg_name" {
  type        = string
  description = "Name of the resource group where the resources get deployed to"
  default     = "az-migration-resources"
}

variable "rg_location" {
  type        = string
  description = "Name of the region where the resources get deployed to"
  default     = "East Us 2"
}

variable "workbook_file" {
  type        = string
  description = "Name of the az workbook"
  default     = "SubscriptionMigrationAssessment.workbook"
}

variable "workbook_displayname" {
  type        = string
  description = "Name of the az workbook"
  default     = "Subscription Migration Assessment"
}
