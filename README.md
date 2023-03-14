# Azure Subscription Migration

Migration of subscriptions between tenants.

> **Warning**
> Check the Microsoft Migration [documentation][ms_transfer_sub] to get a list of all resources that will be impacted.

## Subscription Assessment

Deploy the [Azure Monitor Workbook][az_sub_workbook] to view the resources that are impacted during the migration of a subscription to a different tenant. The workbook provides a live view of the resources impacted in the migration process across multiple subscriptions. The workbook is deployed per tenant and can be provisioned manually or using the provided terraform code.

## Process Overview for the Subscription Migration

1. Plan for the migration
2. Prepare for the transfer
3. Transfer the Azure subscription to a different directory
   1. Transfer billing ownership
      1. Microsoft Online Services Program (MOSP) - also referred to as pay-as-you-go, Azure subscription to another MOSP account. [Transfer Documentation][MOSP_Transfer]
      2. Enterprise Agreement (EA) customer, your enterprise administrator can transfer billing ownership of your subscriptions between accounts. [EA Transfer Documentation][ea_transfer]
4. Re-create resources in the target directory such as role assignments, custom roles, and managed identities

## After the Subscription Transfer

* It may take upwards of 20 minutes to view the subscription in the new directory
* It may take up to 30 minutes for the subscription to show in the management group structure
* All RBAC assignments in the source tenant are removed from the subscription scope. In the destination tenant the subscription will inherit the user access administrator from the Root (Inherited) scope [Elevated Access][ms_elevated_access]
* The user who triggered the transfer will be assigned the classic administrator role. [Elevated Access][ms_elevated_access]



<!--- Link Ref --->
[ms_transfer_sub]: https://learn.microsoft.com/azure/role-based-access-control/transfer-subscription
[az_sub_workbook]: az_workbooks/README.md
[ms_elevated_access]: https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin#how-does-elevated-access-work
[ms_transfer_bill]: https://learn.microsoft.com/azure/cost-management-billing/manage/billing-subscription-transfer
[MOSP_Transfer]: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/billing-subscription-transfer
[ea_transfer]: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/ea-portal-administration#change-azure-subscription-or-account-ownership
<!--- Link Ref --->
