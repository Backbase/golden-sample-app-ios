# ArrangementsAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getArrangementById**](ArrangementsAPI.md#getarrangementbyid) | **GET** /client-api/v2/arrangements/{arrangementId} | 
[**getArrangementChildren**](ArrangementsAPI.md#getarrangementchildren) | **GET** /client-api/v2/arrangements/{arrangementId}/children | 
[**getLinked**](ArrangementsAPI.md#getlinked) | **GET** /client-api/v2/arrangements/linked | 
[**getUserPreferences**](ArrangementsAPI.md#getuserpreferences) | **GET** /client-api/v2/arrangements/user-preferences | 
[**linkExternalLegalEntity**](ArrangementsAPI.md#linkexternallegalentity) | **POST** /client-api/v2/arrangements/link/{externalLegalEntityId} | 
[**unlinkExternalLegalEntity**](ArrangementsAPI.md#unlinkexternallegalentity) | **POST** /client-api/v2/arrangements/unlink/{externalLegalEntityId}/{externalArrangementId} | 
[**unmaskedAttribute**](ArrangementsAPI.md#unmaskedattribute) | **GET** /client-api/v2/arrangements/{arrangementId}/unmasked-attributes/{attributeName} | 
[**updateUserPreferences**](ArrangementsAPI.md#updateuserpreferences) | **PUT** /client-api/v2/arrangements/user-preferences | 


# **getArrangementById**
```swift
    open class func getArrangementById(arrangementId: String, contentLanguage: String? = nil, maskIndicator: Bool? = nil, completion: @escaping (_ data: AccountArrangementItem?, _ error: Error?) -> Void)
```



Retrieve a single arrangement with details.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementId = "arrangementId_example" // String | Arrangement Id
let contentLanguage = "contentLanguage_example" // String | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
let maskIndicator = true // Bool | Masked/Unmasked card number (optional)

ArrangementsAPI.getArrangementById(arrangementId: arrangementId, contentLanguage: contentLanguage, maskIndicator: maskIndicator) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **arrangementId** | **String** | Arrangement Id | 
 **contentLanguage** | **String** | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. | [optional] 
 **maskIndicator** | **Bool** | Masked/Unmasked card number | [optional] 

### Return type

[**AccountArrangementItem**](AccountArrangementItem.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArrangementChildren**
```swift
    open class func getArrangementChildren(arrangementId: String, from: Int? = nil, size: Int? = nil, completion: @escaping (_ data: [ChildArrangementResult]?, _ error: Error?) -> Void)
```



Retrieve child arrangements.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementId = "arrangementId_example" // String | Arrangement Id
let from = 987 // Int | Page Number. Skip over pages of elements by specifying a start value for the query (optional) (default to 0)
let size = 987 // Int | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  (optional) (default to 10)

ArrangementsAPI.getArrangementChildren(arrangementId: arrangementId, from: from, size: size) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **arrangementId** | **String** | Arrangement Id | 
 **from** | **Int** | Page Number. Skip over pages of elements by specifying a start value for the query | [optional] [default to 0]
 **size** | **Int** | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  | [optional] [default to 10]

### Return type

[**[ChildArrangementResult]**](ChildArrangementResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getLinked**
```swift
    open class func getLinked(legalEntityId: String, from: Int? = nil, size: Int? = nil, completion: @escaping (_ data: AccountLinkedArrangementItems?, _ error: Error?) -> Void)
```



Retrieves a list of arrangements for a given external legal entity with information if linked or unlinked.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let legalEntityId = "legalEntityId_example" // String | External Legal entity Id
let from = 987 // Int | Page Number. Skip over pages of elements by specifying a start value for the query (optional) (default to 0)
let size = 987 // Int | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  (optional) (default to 10)

ArrangementsAPI.getLinked(legalEntityId: legalEntityId, from: from, size: size) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **legalEntityId** | **String** | External Legal entity Id | 
 **from** | **Int** | Page Number. Skip over pages of elements by specifying a start value for the query | [optional] [default to 0]
 **size** | **Int** | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  | [optional] [default to 10]

### Return type

[**AccountLinkedArrangementItems**](AccountLinkedArrangementItems.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserPreferences**
```swift
    open class func getUserPreferences(arrangementId: String, completion: @escaping (_ data: AccountUserPreferences?, _ error: Error?) -> Void)
```



Retrieve user defined preferences for arrangement id

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementId = "arrangementId_example" // String | arrangement id

ArrangementsAPI.getUserPreferences(arrangementId: arrangementId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **arrangementId** | **String** | arrangement id | 

### Return type

[**AccountUserPreferences**](AccountUserPreferences.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **linkExternalLegalEntity**
```swift
    open class func linkExternalLegalEntity(externalLegalEntityId: String, accountLinkedArrangementItem: AccountLinkedArrangementItem, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```



Link an arrangement to the given external legal entity or persist it to DBS

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let externalLegalEntityId = "externalLegalEntityId_example" // String | external legal entity id
let accountLinkedArrangementItem = AccountLinkedArrangementItem(linked: false, legalEntityIds: ["legalEntityIds_example"], product: ExternalProductItem(externalId: "externalId_example", externalTypeId: "externalTypeId_example", typeName: "typeName_example", productKind: ExternalProductKindItem(externalKindId: "externalKindId_example", kindName: "kindName_example", kindUri: "kindUri_example", additions: "TODO"), additions: "TODO"), externalArrangementId: "externalArrangementId_example", productId: "productId_example", displayName: "displayName_example", debitCards: [DebitCardItem(unmaskableAttributes: [MaskableAttribute()], number: "number_example", expiryDate: "expiryDate_example", cardId: "cardId_example", cardholderName: "cardholderName_example", cardType: "cardType_example", cardStatus: "cardStatus_example", additions: "TODO")], unmaskableAttributes: [nil], name: "name_example", bookedBalance: 123, availableBalance: 123, creditLimit: 123, IBAN: "IBAN_example", BBAN: "BBAN_example", BIC: "BIC_example", currency: "currency_example", externalTransferAllowed: false, urgentTransferAllowed: false, accruedInterest: 123, number: "number_example", principalAmount: 123, currentInvestmentValue: 123, productNumber: "productNumber_example", bankBranchCode: "bankBranchCode_example", accountOpeningDate: Date(), accountInterestRate: 123, valueDateBalance: 123, creditLimitUsage: 123, creditLimitInterestRate: 123, creditLimitExpiryDate: Date(), startDate: Date(), termUnit: TimeUnit(), termNumber: 123, interestPaymentFrequencyUnit: nil, interestPaymentFrequencyNumber: 123, maturityDate: Date(), maturityAmount: 123, autoRenewalIndicator: false, interestSettlementAccount: "interestSettlementAccount_example", outstandingPrincipalAmount: 123, monthlyInstalmentAmount: 123, amountInArrear: 123, minimumRequiredBalance: 123, creditCardAccountNumber: "creditCardAccountNumber_example", validThru: Date(), applicableInterestRate: 123, remainingCredit: 123, outstandingPayment: 123, minimumPayment: 123, minimumPaymentDueDate: Date(), totalInvestmentValue: 123, accountHolderAddressLine1: "accountHolderAddressLine1_example", accountHolderAddressLine2: "accountHolderAddressLine2_example", accountHolderStreetName: "accountHolderStreetName_example", town: "town_example", postCode: "postCode_example", countrySubDivision: "countrySubDivision_example", accountHolderNames: "accountHolderNames_example", accountHolderCountry: "accountHolderCountry_example", creditAccount: false, debitAccount: false, lastUpdateDate: Date(), bankAlias: "bankAlias_example", sourceId: "sourceId_example", externalStateId: "externalStateId_example", externalParentId: "externalParentId_example", financialInstitutionId: 123, lastSyncDate: Date(), credentialsExpired: false, externalAccountStatus: "externalAccountStatus_example", additions: "TODO") // AccountLinkedArrangementItem | 

ArrangementsAPI.linkExternalLegalEntity(externalLegalEntityId: externalLegalEntityId, accountLinkedArrangementItem: accountLinkedArrangementItem) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **externalLegalEntityId** | **String** | external legal entity id | 
 **accountLinkedArrangementItem** | [**AccountLinkedArrangementItem**](AccountLinkedArrangementItem.md) |  | 

### Return type

Void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unlinkExternalLegalEntity**
```swift
    open class func unlinkExternalLegalEntity(externalLegalEntityId: String, externalArrangementId: String, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```



Unlink an arrangement from the given legal entity if all privileges are removed

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let externalLegalEntityId = "externalLegalEntityId_example" // String | external legal entity id
let externalArrangementId = "externalArrangementId_example" // String | external arrangement id

ArrangementsAPI.unlinkExternalLegalEntity(externalLegalEntityId: externalLegalEntityId, externalArrangementId: externalArrangementId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **externalLegalEntityId** | **String** | external legal entity id | 
 **externalArrangementId** | **String** | external arrangement id | 

### Return type

Void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **unmaskedAttribute**
```swift
    open class func unmaskedAttribute(arrangementId: String, attributeName: MaskableAttribute, completion: @escaping (_ data: String?, _ error: Error?) -> Void)
```



Returns the unmasked value of the requested attribute.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementId = "arrangementId_example" // String | Arrangement Id
let attributeName = MaskableAttribute() // MaskableAttribute | The attribute to be unmasked

ArrangementsAPI.unmaskedAttribute(arrangementId: arrangementId, attributeName: attributeName) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **arrangementId** | **String** | Arrangement Id | 
 **attributeName** | [**MaskableAttribute**](.md) | The attribute to be unmasked | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUserPreferences**
```swift
    open class func updateUserPreferences(accountUserPreferences: AccountUserPreferences, completion: @escaping (_ data: Void?, _ error: Error?) -> Void)
```



Update user defined preferences for arrangement id

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let accountUserPreferences = AccountUserPreferences(arrangementId: "arrangementId_example", alias: "alias_example", visible: false, favorite: false, additions: "TODO") // AccountUserPreferences | 

ArrangementsAPI.updateUserPreferences(accountUserPreferences: accountUserPreferences) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountUserPreferences** | [**AccountUserPreferences**](AccountUserPreferences.md) |  | 

### Return type

Void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

