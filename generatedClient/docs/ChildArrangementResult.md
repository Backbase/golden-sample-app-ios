# ChildArrangementResult

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The name that can be assigned by the bank to label an arrangement | [optional] 
**displayName** | **String** | Represents an arrangement by it&#39;s correct naming identifier. It could be account alias or user alias depending on the journey selected by the financial institution. If none of those is set, the arrangement name will be used.  | [optional] 
**currency** | **String** | The alpha-3 code (complying with ISO 4217) of the currency that qualifies the amount. | 
**bookedBalance** | **Double** | Amount of money available before any adjustments have been made for deposits in transit, checks that have not yet been cleared, reserve requirements and interest received | [optional] 
**accountOpeningDate** | **Date** | The date of activation of the account in the bank&#39;s system | [optional] 
**maturityDate** | **Date** | End term of a holding period | [optional] 
**maturityAmount** | **Double** | Amount payable at the end of a holding period of a product (maturity date). For deposit all of the interest is usualy paid at maturity date (IF the term is shorter then one year). | [optional] 
**additions** | **[String: String]** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

