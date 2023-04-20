﻿ Connect-AzAccount 


install-module -Name az.resourcegraph -AllowClobber

 import-module az.resourcegraph 


$subscriptions = get-azsubscription  

$subscription = $subscriptions | ogv -Title " Select Subscription" -PassThru | select  name, id, tenantid


set-azcontext -Subscription $($subscription.Name)


$workbooks = Get-AzApplicationInsightsMyWorkbook -SubscriptionId $($subscription.Id) -Category 'workbook'



foreach($workbook in $workbooks)
{
 
 $querylist = ''

 $workbookpath  = "C:\temp\"
 $workbookname = "$($workbook.name)"
  $workbookdisplayname = "$($workbook.displayname)"
 ###########################################

 $workbook = Get-AzApplicationInsightsWorkbook   -CanFetchContent  -Category 'workbook' | select -property *

 $jsonresource  = $workbook.serializeddata  | convertfrom-json


  
###########################

# Read in the Azure Workbook template


 
# Extract the query from the workbook parameters
 #$parameters = $jsonresource.items | Where-Object { $_.type -eq 9 } | Select-Object -ExpandProperty content
 

# Extract the subscription IDs from the workbook source data
 #$sourceData = $jsonresource.items | Where-Object { $_.type -eq 11 } | Select-Object -ExpandProperty content #.links

$sourcequeries = $jsonresource.items  | select-object -ExpandProperty content
$queries = $sourcequeries.items.content.query 

$links = $($sourceData.links).linklabel
 
  
    Foreach($jsonitem in ($sourcequeries) )# | where-object { $_.items.content.query  -ne $null})| Select * )
    {

         #   Write-host "$($jsonitem.items.content.query)" -ForegroundColor Cyan

     

                foreach($jsonitemcontent in ($($jsonitem.items.content) | where query -ne $null )  )
                {
                    
                    $contentprops = $($jsonitem.items.content)  
    
                    $contenttypes = $($jsonitem.items.type)

                    foreach($contenttype in $contenttypes)
                    {
 
                        $jsoncontentobj = new-object PSObject 

                       $contentitems =  $($jsonitem.items.content)  
                       $Feature =  $($contentitems.json) -replace('{#','')

                    

                        $tablabels = $($jsonitem.items.links).linklabel

                        $tablabels

                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name Type -value $($contenttype)
                       # $jsoncontentobj | Add-Member -MemberType NoteProperty -Name linklabel -value   $tablabels
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name Feature -value "$Feature"
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name Version -value $($jsonitemcontent.version)  
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name title -value $($jsonitemcontent.title)      
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name noDataMessage -value $($jsonitemcontent.noDataMessage)
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name queryType -value $($jsonitemcontent.queryType)  
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name resourceType -value $($jsonitemcontent.resourceType)      
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name crossComponentResources -value $($jsonitemcontent.crossComponentResources)
                        $jsoncontentobj | Add-Member -MemberType NoteProperty -Name query -value $($jsonitemcontent.query).ToString()  
           
 
        
                       # $jsoncontentobj
                        [array]$querylist +=    $jsoncontentobj
               


                        } 
                 }
         
 }



 #############################################################
 
 
 $CSS = @"
<Title>$workbook Query ReportReport:$(Get-Date -Format 'dd MMMM yyyy' )</Title>
<Style>
th {
	font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica,
	sans-serif;
	color: #FFFFFF;
	border-right: 1px solid #C1DAD7;
	border-bottom: 1px solid #C1DAD7;
	border-top: 1px solid #C1DAD7;
	letter-spacing: 2px;
	text-transform: uppercase;
	text-align: left;
	padding: 6px 6px 6px 12px;
	background: #5F9EA0;
}
td {
	font: 11px "Trebuchet MS", Verdana, Arial, Helvetica,
	sans-serif;
	border-right: 1px solid #C1DAD7;
	border-bottom: 1px solid #C1DAD7;
	background: #fff;
	padding: 6px 6px 6px 12px;
	color: #6D929B;
}
</Style>
"@

 

    (($querylist | Select  -unique   Version,title, noDataMessage,queryType , resourceType, crossComponentResources,query  |`
      ConvertTo-Html -Head $CSS ).replace('Â Â','')) | out-file  "c:\temp\$($workbookname)Queries.html"
    invoke-item  "c:\temp\$($workbookname)Queries.html"
 
     $querylist | Select -unique   Version,title, noDataMessage,queryType , resourceType, crossComponentResources,query |  `
     export-csv "C:\temp\$($workbookname)Queries.csv" -NoTypeInformation
 
    }
 





















