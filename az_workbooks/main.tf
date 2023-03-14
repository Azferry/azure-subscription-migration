
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_application_insights_workbook" "wb" {
  name                = uuid()
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  display_name        = var.workbook_displayname
  data_json           = jsonencode(file(var.workbook_file))
  tags = {
    AzMigration = "Assessment"
  }
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
