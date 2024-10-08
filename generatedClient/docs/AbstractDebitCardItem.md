# AbstractDebitCardItem

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**number** | **String** | First 6 and/or last 4 digits of a Payment card. All other digits will/to be masked. Be aware that using card number differently is potential PCI risk. | [optional] 
**expiryDate** | **String** | Expiration date of a credit card, after which is no longer valid | [optional] 
**cardId** | **String** | External ID of the card | [optional] 
**cardholderName** | **String** | First Name and Last Name of card holder. | [optional] 
**cardType** | **String** | Card type to change card image based on it, ex. Maestro Gold | [optional] 
**cardStatus** | **String** | Status of the card ex. Active, Expired etc | [optional] 
**additions** | **[String: String]** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

