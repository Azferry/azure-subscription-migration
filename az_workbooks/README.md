# Assessment Workbook

The workbook provides a live view of the resources impacted in the migration process across multiple subscriptions. The workbook is deployed per tenant and can be provisioned manually or using the provided terraform code.

## How to Deploy

### Deploy Via terraform

The workbook can be deployed with the terrafrom code in this directory.

```powershell
# Login to azure
az login

# Initialize the terrafrom modules
cd .\az_workbooks
terraform init

# Run the apply to deploy the resources
terraform apply

# Cleanup resources 
terraform destroy
```

### Deploy Via Azure Portal

1. Navigate to the [Azure Monitor][wb_portal] in the portal
2. Under the Quick Start select "Empty" Workbook
3. On the top bar select the "Advanced Editor" ("</>")
4. Copy and paste the gallery template json and select apply
5. Select the done editing button on the top bar
6. Save the workbook

<!--- Link Ref --->
[wb_portal]: https://portal.azure.com/#view/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/~/workbooks
<!--- Link Ref --->
