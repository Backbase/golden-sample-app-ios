# BalancesAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAggregations**](BalancesAPI.md#getaggregations) | **GET** /client-api/v2/balances/aggregations | 
[**getFavoriteCurrencies**](BalancesAPI.md#getfavoritecurrencies) | **GET** /client-api/v2/balances/aggregations/favorites/currencies | 


# **getAggregations**
```swift
    open class func getAggregations(contentLanguage: String? = nil, productKindIds: [Int]? = nil, externalProductKindIds: [String]? = nil, groupedBy: GroupedBy_getAggregations? = nil, includeTotals: Bool? = nil, completion: @escaping (_ data: [AggregatedBalances]?, _ error: Error?) -> Void)
```



Retrieves aggregated balances ordered by favorite currencies.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let contentLanguage = "contentLanguage_example" // String | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
let productKindIds = [123] // [Int] | Filters arrangements by given product kind ids and aggregates their balances. Since product kinds will be static this property is deprecated, please use externalProductKindIds. (optional)
let externalProductKindIds = ["inner_example"] // [String] | Filters arrangements by given external product kind ids and aggregates their balances. (optional)
let groupedBy = "groupedBy_example" // String | Groups arrangements by id of given parameter and aggregates their balances. If it is empty, then it aggregates balances for all arrangements (optional)
let includeTotals = true // Bool | Includes total aggregations by currency as a first item of the list in response when it is true otherwise, it doesn't. (optional) (default to false)

BalancesAPI.getAggregations(contentLanguage: contentLanguage, productKindIds: productKindIds, externalProductKindIds: externalProductKindIds, groupedBy: groupedBy, includeTotals: includeTotals) { (response, error) in
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
 **productKindIds** | [**[Int]**](Int.md) | Filters arrangements by given product kind ids and aggregates their balances. Since product kinds will be static this property is deprecated, please use externalProductKindIds. | [optional] 
 **externalProductKindIds** | [**[String]**](String.md) | Filters arrangements by given external product kind ids and aggregates their balances. | [optional] 
 **groupedBy** | **String** | Groups arrangements by id of given parameter and aggregates their balances. If it is empty, then it aggregates balances for all arrangements | [optional] 
 **includeTotals** | **Bool** | Includes total aggregations by currency as a first item of the list in response when it is true otherwise, it doesn&#39;t. | [optional] [default to false]

### Return type

[**[AggregatedBalances]**](AggregatedBalances.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getFavoriteCurrencies**
```swift
    open class func getFavoriteCurrencies(completion: @escaping (_ data: [AggregatedBalance]?, _ error: Error?) -> Void)
```



Retrieve aggregated balances in favorite currencies

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi


BalancesAPI.getFavoriteCurrencies() { (response, error) in
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
This endpoint does not need any parameter.

### Return type

[**[AggregatedBalance]**](AggregatedBalance.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

