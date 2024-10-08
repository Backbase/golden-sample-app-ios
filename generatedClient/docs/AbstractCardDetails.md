# AbstractCardDetails

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**cardProvider** | **String** | This field specifies the Card Provider associated with the Account.  *Example*: Maestro, Visa, Master Card, American Express or Discover.  | 
**secured** | **Bool** | A card can either be Secured or Unsecured.   - *true*: amount deposited in the CC determines the Limit.   - *false*: credit limit is based off various factors including the CC holder’s Credit Score,   Credit History and is determined by the lending bank.  | [optional] 
**availableCashCredit** | **Double** | The amount of money currently available for a bank cash advance.  This is calculated given the portion of the CashCreditLimit which has been used for Cash Advance Transactions.  | [optional] 
**cashCreditLimit** | **Double** | The portion of the credit limit available for bank cash advance transactions..  | [optional] 
**lastPaymentDate** | **Date** | The Date the last payment was made on the Credit-based arrangement  | [optional] 
**lastPaymentAmount** | **Double** | The amount of the last payment that was made on the Credit-based arrangement.  | [optional] 
**latePaymentFee** | **String** | The charge triggered by infractions such as late credit card payments. It can be expressed as fixed amount or as percent.  *Example*:   - *12.32*: as fixed amount   - *3.14%*: as percent  | [optional] 
**previousStatementDate** | **Date** | The date of the previous billing cycle for the arrangement.  | [optional] 
**previousStatementBalance** | **Double** | The amount owed on the credit card as of the previous billing cycle.  | [optional] 
**statementBalance** | **Double** | The amount owed on the credit card as of the latest billing cycle.   | [optional] 
**additions** | **[String: String]** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

