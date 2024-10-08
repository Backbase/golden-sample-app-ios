# BaseProduct

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | Reference to the product of which the arrangement is an instantiation. | [optional] 
**name** | **String** |  | [optional] 
**displayName** | **String** | Represents an arrangement by it&#39;s correct naming identifier. It could be account alias or user alias depending on the journey selected by the financial institution. If none of those is set, the arrangement name will be used.  | [optional] 
**externalTransferAllowed** | **Bool** | Defines if transfer to another party is allowed. | [optional] 
**crossCurrencyAllowed** | **Bool** | Defines if cross currency transfer is allowed | [optional] 
**productKindName** | **String** | The label/name that is used for the respective product kind | [optional] 
**productTypeName** | **String** | The label/name that is used to label a specific product type | [optional] 
**bankAlias** | **String** | The name that can be assigned by the bank to label the arrangement. | [optional] 
**sourceId** | **String** | Indicate if the account is regular or external | [optional] 
**visible** | **Bool** | indicator whether to show or hide the arrangement on the widget | [optional] 
**accountOpeningDate** | **Date** |  | [optional] 
**lastUpdateDate** | **Date** | Last date of parameter update for the arrangement. | [optional] 
**userPreferences** | [**UserPreferences**](UserPreferences.md) |  | [optional] 
**state** | [**StateItem**](StateItem.md) |  | [optional] 
**parentId** | **String** | Reference to the parent of the arrangement. | [optional] 
**subArrangements** | [BaseProduct] |  | [optional] 
**financialInstitutionId** | **Int64** | Financial institution ID | [optional] 
**lastSyncDate** | **Date** | Last synchronization datetime | [optional] 
**cardDetails** | [**CardDetails**](CardDetails.md) |  | [optional] 
**interestDetails** | [**InterestDetails**](InterestDetails.md) |  | [optional] 
**reservedAmount** | **Double** | The reservation of a portion of a credit or debit balance for the cost of services not yet rendered.  | [optional] 
**remainingPeriodicTransfers** | **Double** | The limitation in periodic saving transfers or withdrawals. In the case of the US, Regulation D enables for a maximum of 6 monthly savings transfers or withdrawals.  | [optional] 
**bankBranchCode2** | **String** | Another country-specific bank identification number or code: the Fedwire Routing Number in the US or another country-specific identifier.  | [optional] 
**nextClosingDate** | **Date** | The last day of the forthcoming billing cycle. | [optional] 
**overdueSince** | **Date** | The date in which the arrangement has been overdue since. | [optional] 
**credentialsExpired** | **Bool** | DEPRECATED: the attribute is deprecated and ignored by Backend  | [optional] 
**externalAccountStatus** | **String** | Synchronization statuses an account can have on the provider side after it has been aggregated.  | [optional] 
**additions** | **[String: String]** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

