# ProductSummaryAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getArrangementsByBusinessFunction**](ProductSummaryAPI.md#getarrangementsbybusinessfunction) | **GET** /client-api/v2/productsummary/context/arrangements | 
[**getProductSummary**](ProductSummaryAPI.md#getproductsummary) | **GET** /client-api/v2/productsummary | 
[**getProductSummaryEntitlementsByLegalEntityId**](ProductSummaryAPI.md#getproductsummaryentitlementsbylegalentityid) | **GET** /client-api/v2/productsummary/configuration | 
[**postFilterProductSummaries**](ProductSummaryAPI.md#postfilterproductsummaries) | **POST** /client-api/v2/productsummary/configuration/filter | 


# **getArrangementsByBusinessFunction**
```swift
    open class func getArrangementsByBusinessFunction(businessFunction: String, resourceName: String, privilege: String, contentLanguage: String? = nil, withLatestBalances: Bool? = nil, maskIndicator: Bool? = nil, debitAccount: Bool? = nil, creditAccount: Bool? = nil, externalTransferAllowed: Bool? = nil, productKindName: String? = nil, legalEntityIds: [String]? = nil, sourceId: String? = nil, favorite: Bool? = nil, searchTerm: String? = nil, customOrder: Bool? = nil, favoriteFirst: Bool? = nil, subscriptions: [String]? = nil, hasParent: Bool? = nil, from: Int? = nil, size: Int? = nil, cursor: String? = nil, orderBy: [OrderByField]? = nil, direction: SortDirection? = nil, ignoredProductKindNames: [String]? = nil, productKindNames: [String]? = nil, completion: @escaping (_ data: [ProductSummaryItem]?, _ error: Error?) -> Void)
```



Get a list of arrangements according to a given business functions

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let businessFunction = "businessFunction_example" // String | Provide comma separated contexts for retrieving arrangements
let resourceName = "resourceName_example" // String | Provide the resource for retrieving arrangements
let privilege = "privilege_example" // String | Privilege for the arrangements
let contentLanguage = "contentLanguage_example" // String | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
let withLatestBalances = true // Bool | Retrieve a list of arrangements with the latest balances (optional) (default to true)
let maskIndicator = true // Bool | Masked/Unmasked card number (optional)
let debitAccount = true // Bool | Type of account (optional)
let creditAccount = true // Bool | Type of account (optional)
let externalTransferAllowed = false // Bool | Privilege for external transfers (optional)
let productKindName = "productKindName_example" // String | Product Kind Name (optional)
let legalEntityIds = ["inner_example"] // [String] | A list of legal entities ids to filter by (optional)
let sourceId = "sourceId_example" // String | No description available (optional)
let favorite = true // Bool | Indicates whether an arrangement is favorite for a user or not (optional)
let searchTerm = "searchTerm_example" // String | Full text search (optional)
let customOrder = true // Bool | Parameter that identifies weather the returned list should be ordered by custom order/grouping (optional)
let favoriteFirst = true // Bool | Parameter that sets favorite arrangements on top when true (optional) (default to false)
let subscriptions = ["inner_example"] // [String] | A list of subscription identifiers (optional)
let hasParent = true // Bool | Parameter that filters out arrangements where parentId is not null (optional)
let from = 987 // Int | Page Number. Skip over pages of elements by specifying a start value for the query (optional) (default to 0)
let size = 987 // Int | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  (optional) (default to 10)
let cursor = "cursor_example" // String | Record UUID. As an alternative for specifying 'from' this allows to point to the record to start the selection from.  (optional) (default to "")
let orderBy = [OrderByField()] // [OrderByField] | Order by field (optional)
let direction = SortDirection() // SortDirection | Direction (optional)
let ignoredProductKindNames = ["inner_example"] // [String] | Product kind names to be ignored (optional)
let productKindNames = ["inner_example"] // [String] | Product kind names to be considered in the query (optional)

ProductSummaryAPI.getArrangementsByBusinessFunction(businessFunction: businessFunction, resourceName: resourceName, privilege: privilege, contentLanguage: contentLanguage, withLatestBalances: withLatestBalances, maskIndicator: maskIndicator, debitAccount: debitAccount, creditAccount: creditAccount, externalTransferAllowed: externalTransferAllowed, productKindName: productKindName, legalEntityIds: legalEntityIds, sourceId: sourceId, favorite: favorite, searchTerm: searchTerm, customOrder: customOrder, favoriteFirst: favoriteFirst, subscriptions: subscriptions, hasParent: hasParent, from: from, size: size, cursor: cursor, orderBy: orderBy, direction: direction, ignoredProductKindNames: ignoredProductKindNames, productKindNames: productKindNames) { (response, error) in
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
 **businessFunction** | **String** | Provide comma separated contexts for retrieving arrangements | 
 **resourceName** | **String** | Provide the resource for retrieving arrangements | 
 **privilege** | **String** | Privilege for the arrangements | 
 **contentLanguage** | **String** | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. | [optional] 
 **withLatestBalances** | **Bool** | Retrieve a list of arrangements with the latest balances | [optional] [default to true]
 **maskIndicator** | **Bool** | Masked/Unmasked card number | [optional] 
 **debitAccount** | **Bool** | Type of account | [optional] 
 **creditAccount** | **Bool** | Type of account | [optional] 
 **externalTransferAllowed** | **Bool** | Privilege for external transfers | [optional] 
 **productKindName** | **String** | Product Kind Name | [optional] 
 **legalEntityIds** | [**[String]**](String.md) | A list of legal entities ids to filter by | [optional] 
 **sourceId** | **String** | No description available | [optional] 
 **favorite** | **Bool** | Indicates whether an arrangement is favorite for a user or not | [optional] 
 **searchTerm** | **String** | Full text search | [optional] 
 **customOrder** | **Bool** | Parameter that identifies weather the returned list should be ordered by custom order/grouping | [optional] 
 **favoriteFirst** | **Bool** | Parameter that sets favorite arrangements on top when true | [optional] [default to false]
 **subscriptions** | [**[String]**](String.md) | A list of subscription identifiers | [optional] 
 **hasParent** | **Bool** | Parameter that filters out arrangements where parentId is not null | [optional] 
 **from** | **Int** | Page Number. Skip over pages of elements by specifying a start value for the query | [optional] [default to 0]
 **size** | **Int** | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  | [optional] [default to 10]
 **cursor** | **String** | Record UUID. As an alternative for specifying &#39;from&#39; this allows to point to the record to start the selection from.  | [optional] [default to &quot;&quot;]
 **orderBy** | [**[OrderByField]**](OrderByField.md) | Order by field | [optional] 
 **direction** | [**SortDirection**](.md) | Direction | [optional] 
 **ignoredProductKindNames** | [**[String]**](String.md) | Product kind names to be ignored | [optional] 
 **productKindNames** | [**[String]**](String.md) | Product kind names to be considered in the query | [optional] 

### Return type

[**[ProductSummaryItem]**](ProductSummaryItem.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductSummary**
```swift
    open class func getProductSummary(contentLanguage: String? = nil, debitAccount: Bool? = nil, creditAccount: Bool? = nil, maskIndicator: Bool? = nil, ignoredProductKindNames: [String]? = nil, businessFunction: String? = nil, resourceName: String? = nil, privilege: String? = nil, completion: @escaping (_ data: ProductSummary?, _ error: Error?) -> Void)
```



Retrieve list of products summaries.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let contentLanguage = "contentLanguage_example" // String | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
let debitAccount = true // Bool | Type of account (optional)
let creditAccount = true // Bool | Type of account (optional)
let maskIndicator = true // Bool | Masked/Unmasked card number (optional)
let ignoredProductKindNames = ["inner_example"] // [String] | Product kind names to be ignored (optional)
let businessFunction = "businessFunction_example" // String | Select arrangements current user has permission to perform this business function. (optional)
let resourceName = "resourceName_example" // String | In combination with businessFunction parameter, defines the resource. (optional)
let privilege = "privilege_example" // String | In combination with businessFunction parameter, defines the privilege. (optional)

ProductSummaryAPI.getProductSummary(contentLanguage: contentLanguage, debitAccount: debitAccount, creditAccount: creditAccount, maskIndicator: maskIndicator, ignoredProductKindNames: ignoredProductKindNames, businessFunction: businessFunction, resourceName: resourceName, privilege: privilege) { (response, error) in
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
 **contentLanguage** | **String** | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. | [optional] 
 **debitAccount** | **Bool** | Type of account | [optional] 
 **creditAccount** | **Bool** | Type of account | [optional] 
 **maskIndicator** | **Bool** | Masked/Unmasked card number | [optional] 
 **ignoredProductKindNames** | [**[String]**](String.md) | Product kind names to be ignored | [optional] 
 **businessFunction** | **String** | Select arrangements current user has permission to perform this business function. | [optional] 
 **resourceName** | **String** | In combination with businessFunction parameter, defines the resource. | [optional] 
 **privilege** | **String** | In combination with businessFunction parameter, defines the privilege. | [optional] 

### Return type

[**ProductSummary**](ProductSummary.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductSummaryEntitlementsByLegalEntityId**
```swift
    open class func getProductSummaryEntitlementsByLegalEntityId(legalEntityIds: [String], arrangementIds: [String]? = nil, ignoredArrangementIds: [String]? = nil, searchTerm: String? = nil, from: Int? = nil, size: Int? = nil, cursor: String? = nil, orderBy: [OrderByField]? = nil, direction: SortDirection? = nil, completion: @escaping (_ data: [ProductSummaryItem]?, _ error: Error?) -> Void)
```



Retrieve list of products summaries, flat structure. Use POST /client-api/v2/productsummary/configuration/filter instead. Always returns null for the userPreferences field. 

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let legalEntityIds = ["inner_example"] // [String] | legal entity ids
let arrangementIds = ["inner_example"] // [String] | arrangement ids (optional)
let ignoredArrangementIds = ["inner_example"] // [String] | No description available (optional)
let searchTerm = "searchTerm_example" // String | Full text search (optional)
let from = 987 // Int | Page Number. Skip over pages of elements by specifying a start value for the query (optional) (default to 0)
let size = 987 // Int | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  (optional) (default to 10)
let cursor = "cursor_example" // String | Record UUID. As an alternative for specifying 'from' this allows to point to the record to start the selection from.  (optional) (default to "")
let orderBy = [OrderByField()] // [OrderByField] | Order by field (optional)
let direction = SortDirection() // SortDirection | Direction (optional)

ProductSummaryAPI.getProductSummaryEntitlementsByLegalEntityId(legalEntityIds: legalEntityIds, arrangementIds: arrangementIds, ignoredArrangementIds: ignoredArrangementIds, searchTerm: searchTerm, from: from, size: size, cursor: cursor, orderBy: orderBy, direction: direction) { (response, error) in
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
 **legalEntityIds** | [**[String]**](String.md) | legal entity ids | 
 **arrangementIds** | [**[String]**](String.md) | arrangement ids | [optional] 
 **ignoredArrangementIds** | [**[String]**](String.md) | No description available | [optional] 
 **searchTerm** | **String** | Full text search | [optional] 
 **from** | **Int** | Page Number. Skip over pages of elements by specifying a start value for the query | [optional] [default to 0]
 **size** | **Int** | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  | [optional] [default to 10]
 **cursor** | **String** | Record UUID. As an alternative for specifying &#39;from&#39; this allows to point to the record to start the selection from.  | [optional] [default to &quot;&quot;]
 **orderBy** | [**[OrderByField]**](OrderByField.md) | Order by field | [optional] 
 **direction** | [**SortDirection**](.md) | Direction | [optional] 

### Return type

[**[ProductSummaryItem]**](ProductSummaryItem.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postFilterProductSummaries**
```swift
    open class func postFilterProductSummaries(productSummaryFilterParams: ProductSummaryFilterParams, completion: @escaping (_ data: ProductSummaryFilterResult?, _ error: Error?) -> Void)
```



Filter products summaries.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let productSummaryFilterParams = ProductSummaryFilterParams(from: 123, size: 123, legalEntityIds: ["legalEntityIds_example"], arrangementIds: ["arrangementIds_example"], ignoredArrangementIds: ["ignoredArrangementIds_example"], searchTerm: "searchTerm_example", ignoredProductKindNames: ["ignoredProductKindNames_example"], orderBy: [ProductSummaryFilterParamOrderBy()], direction: SortDirection()) // ProductSummaryFilterParams | 

ProductSummaryAPI.postFilterProductSummaries(productSummaryFilterParams: productSummaryFilterParams) { (response, error) in
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
 **productSummaryFilterParams** | [**ProductSummaryFilterParams**](ProductSummaryFilterParams.md) |  | 

### Return type

[**ProductSummaryFilterResult**](ProductSummaryFilterResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

