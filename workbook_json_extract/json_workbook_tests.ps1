 

  

  Connect-AzAccount 

 import-module Az.OperationalInsights
 install-module Az.MachineLearningServices -allowclobber 
import-module Az.MachineLearningServices
Install-Module -Name Az.Monitor
install-module az.migrate  -allowclobber 


$subscription = get-azsubscription -SubscriptionName 'HPC GBB Americas'
set-azcontext -Subscription $($subscription.Name)


#$workbooks = Get-AzApplicationInsightsMyWorkbook -SubscriptionId $($subscription.Id) -Category 'workbook'
 
$workbooks = Get-AzApplicationInsightsWorkbook -SubscriptionId $($subscription.Id) -Category 'workbook'  


foreach($workbook in $workbooks)
 {

 $workspaceName = (Get-AzOperationalInsightsWorkspace -ResourceGroupName $($workbook.resourcegroupname)).name
 
$resource = Get-AzResource  -ResourceGroupName $($workbook.ResourceGroupName) -Name $workspaceName
 
 
$subscriptionId = "$($subscription.id)"
$resourceGroupName = "$($workbook.ResourceGroupName)"
$workspaceName = "$workspaceName"
$workbookName = "$($workbook.displayname)"
$accessToken = (Get-AzAccessToken).Token
 

# Get workbook resource
#$workbook = Get-AzResource -ResourceType "Microsoft.Insights/workbooks"  -ResourceGroupName $($ResourceGroupName)  -ApiVersion 2023-03-01-preview  -ErrorAction Stop
Export-AzResourceGroup -ResourceGroupName $($ResourceGroupName) -Resource '/subscriptions/1d81cec7-7ded-4731-884e-90c5aa59c622/resourceGroups/wolffautorg/providers/microsoft.insights/workbooks/d4a7b8a1-fd88-4736-9611-ce0b87c8b03d'    -path "subscriptiontestworkbookparameters.json" -Force -Confirm:$false
 

# Extract workbook parameters
$parameters = $workbook.Properties.parameters | ConvertFrom-Json

# Save parameters to file
$parameters | ConvertTo-Json -Depth 100 | Out-File -FilePath "C:\temp\parameters.json"
}


set-azcontext -Subscription wolffentpsub

Get -ResourceGroupName $($ResourceGroupName) -Name  "$($workbook.displayname)"
Get-AzCostManagementExport  -Scope wolffentpsub


 Get-AzOperationalInsightsDataExport -ResourceGroupName $($ResourceGroupName) -WorkspaceName $($resource.name)


 Export-AzTemplateSpec -ResourceGroupName $($ResourceGroupName) -Name $($resource.name)



 $workbookresource = Get-AzResource -ResourceType "Microsoft.Insights/workbooks"   

 Export-AzResourceGroup -ResourceGroupName $($ResourceGroupName) -Resource $($workbookresource.ResourceId) -Path c:\temp | where name -like 'd5*'  

 $workbookresource.Properties.parameters | ConvertFrom-Json










