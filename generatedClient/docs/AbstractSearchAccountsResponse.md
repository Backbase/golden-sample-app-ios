# AbstractSearchAccountsResponse

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**externalId** | **String** | A unique external identifier of the account. | 
**name** | **String** | The name that can be assigned by the bank to label an arrangement. | [optional] 
**IBAN** | **String** | The International Bank Account Number. If specified, it must be a valid IBAN, otherwise an invalid value error could be raised.  | [optional] 
**BBAN** | **String** | BBAN is the country-specific bank account number. It is short for Basic Bank Account Number. Account numbers usually match the BBAN.  | [optional] 
**BIC** | **String** | Bank Identifier Code - international bank code that identifies particular banks worldwide | [optional] 
**currency** | **String** | The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount. | 
**externalTransferAllowed** | **Bool** | Defines if transfer to another party is allowed. | [optional] 
**urgentTransferAllowed** | **Bool** | Defines if urgent transfer is allowed. | [optional] 
**number** | **String** | First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked. Be aware that using card number differently is potential PCI risk. | [optional] 
**bankBranchCode** | **String** | A country-specific bank identification number or code: the sort code in the UK, the ACH routing number in the US, and the transit number in Canada  | [optional] 
**accountHolderNames** | **String** | Party(s) with a relationship to the account. | [optional] 
**creditAccount** | **Bool** | Indicator whether or not the arrangement can be used in payment orders as credit account - account to transfer TO. | [optional] 
**debitAccount** | **Bool** | Indicator whether or not the arrangement can be used in payment orders as debit account - account to transfer FROM. | [optional] 
**additions** | **[String: String]** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

