#requires -version 2
<#
.SYNOPSIS
  Gets an export of all management groups and subscriptions under the tenant root group
.DESCRIPTION
  Gets an export of all management groups and subscriptions under the tenant root group and exports it to a CSV file
.NOTES
  LEGAL DISCLAIMER:
    This Sample Code is provided for the purpose of illustration only and is not intended to be used in a production environment. 
    THIS SAMPLE CODE AND ANY RELATED INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE. 
    We grant You a nonexclusive, royalty-free right to use and modify the Sample Code and to reproduce and distribute the object 
    code form of the Sample Code, provided that You agree:
    (i) to not use Our name, logo, or trademarks to market Your software product in which the Sample Code is embedded;
    (ii) to include a valid copyright notice on Your software product in which the Sample Code is embedded; and
    (iii) to indemnify, hold harmless, and defend Us and Our suppliers from and against any claims or lawsuits, including attorneys' fees, 
    that arise or result from the use or distribution of the Sample Code. This posting is provided "AS IS" with no warranties, and confers no rights.
.NOTES
  Version:        V0.1
  Creation Date:  03/15/23
  Pre-requirements:
    - Required premissions: Reader over management group scope
  	- Requred Modules: Az
.EXAMPLE
  Run script
  .\management_group_export.ps1
#>

Connect-AzAccount

Write-Host "Starting management group export"
$csv_prefix = "management_groups"

$output_path = (Get-Location).Path + "\" + ($csv_prefix + ".csv")

$mg_groups = Get-AzManagementGroupEntity
$output = @()

foreach ($mg in $mg_groups) {
    $output += [PSCustomObject]@{
		"Name" = $mg.Type
        "DisplayName" = $mg.DisplayName
        "Id" = $mg.Id
        "ParentId" = $mg.Parent
        "TenantId" = $mg.TenantId
		"Type" = $mg.Type
		"NumberOfDescendants" = $mg.NumberOfDescendants
    }
}

$output | Export-Csv -Path $output_path -NoTypeInformation
Write-Host "Output File Path: $output_path"
Write-Host "Completed management group export"
