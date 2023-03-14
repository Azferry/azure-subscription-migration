# Azure Subscription Migration

Migration of subscriptions between tenants.

> **Warning**
> Check the Microsoft Migration [documentation][ms-transfer-sub] to get a list of all resources that will be impacted.

## Subscription Assessment

The resource assessment scans the subscription to find resources that are impacted during a migration. The script exports all the resources affected into a CSV.
[documentation][arelativelink] 


<!--- Link Ref --->
[ms-transfer-sub]: https://learn.microsoft.com/azure/role-based-access-control/transfer-subscription
[arelativelink]: az_workbooks/README.md
<!--- Link Ref --->
