# Azure Subscription Migration

Migrating an Azure subscription to a new Azure AD tenant can be a complex and time-consuming process that involves a lot of manual overhead.To simplify this process, this repository contains tools and reports that helps reduce the amount of manual overhead when migrating subscriptions to a new Azure AD Tenant.

> **Warning**
> Please note that transferring an Azure subscription to another Azure AD Tenant can have significant impacts on your Azure resources. In some scenarios, transferring a subscription might require downtime to complete the process. Before proceeding with a transition, we strongly recommend that you develop a comprehensive plan for managing the impacts and risks associated.

> **Warning**
>  Many Azure services require security principals (identities) to operate. Please read the Microsoft migration [article][ms_transfer_sub] article that tries to cover most of the Azure services that depend heavily on security principals, but is not a comprehensive list.

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
* It may take up to 30 minutes after the subscription shows in the destination tenant, for the subscription to show in the default management group.
* All RBAC assignments in the source tenant are removed from the subscription scope. In the destination tenant the subscription will inherit the user access administrator from the Root (Inherited) scope [Elevated Access][ms_elevated_access]
* The user who triggered the transfer will be assigned the classic administrator role.



<!--- Link Ref --->
[ms_transfer_sub]: https://learn.microsoft.com/azure/role-based-access-control/transfer-subscription
[az_sub_workbook]: az_workbooks/README.md
[ms_elevated_access]: https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin#how-does-elevated-access-work
[ms_transfer_bill]: https://learn.microsoft.com/azure/cost-management-billing/manage/billing-subscription-transfer
[MOSP_Transfer]: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/billing-subscription-transfer
[ea_transfer]: https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/ea-portal-administration#change-azure-subscription-or-account-ownership
<!--- Link Ref --->
