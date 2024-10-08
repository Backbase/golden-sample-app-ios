# AccountsAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**filterAccounts**](AccountsAPI.md#filteraccounts) | **POST** /client-api/v2/accounts/filter | Account Search
[**getBalanceHistory**](AccountsAPI.md#getbalancehistory) | **GET** /client-api/v2/accounts/balance-history/{arrangementIds} | 
[**getBalanceHistoryForArrangement**](AccountsAPI.md#getbalancehistoryforarrangement) | **GET** /client-api/v2/accounts/balance-history/arrangement/{arrangementId} | 


# **filterAccounts**
```swift
    open class func filterAccounts(filterAccountsRequest: FilterAccountsRequest, completion: @escaping (_ data: [FilterAccountsResponse]?, _ error: Error?) -> Void)
```

Account Search

Allows for searching of accounts in core bank.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let filterAccountsRequest = FilterAccountsRequest(from: 123, size: 123, identifier: "identifier_example", customerId: "customerId_example", accountHolderNames: "accountHolderNames_example") // FilterAccountsRequest | 

// Account Search
AccountsAPI.filterAccounts(filterAccountsRequest: filterAccountsRequest) { (response, error) in
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
 **filterAccountsRequest** | [**FilterAccountsRequest**](FilterAccountsRequest.md) |  | 

### Return type

[**[FilterAccountsResponse]**](FilterAccountsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBalanceHistory**
```swift
    open class func getBalanceHistory(arrangementIds: String, accept: String? = nil, dateFrom: Date? = nil, dateTo: Date? = nil, timePeriod: TimePeriod? = nil, format: Format_getBalanceHistory? = nil, completion: @escaping (_ data: AccountBalanceHistory?, _ error: Error?) -> Void)
```



Retrieve balance history per arrangement for given arrangement ids.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementIds = "arrangementIds_example" // String | comma separated arrangement ids
let accept = "accept_example" // String | Media type that is acceptable for the response. (optional)
let dateFrom = Date() // Date | Bottom value of date range (optional)
let dateTo = Date() // Date | Top value of date range (optional)
let timePeriod = TimePeriod() // TimePeriod | Defined time period for showing graph oscillations (optional)
let format = "format_example" // String | Format of the response (optional)

AccountsAPI.getBalanceHistory(arrangementIds: arrangementIds, accept: accept, dateFrom: dateFrom, dateTo: dateTo, timePeriod: timePeriod, format: format) { (response, error) in
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
 **arrangementIds** | **String** | comma separated arrangement ids | 
 **accept** | **String** | Media type that is acceptable for the response. | [optional] 
 **dateFrom** | **Date** | Bottom value of date range | [optional] 
 **dateTo** | **Date** | Top value of date range | [optional] 
 **timePeriod** | [**TimePeriod**](.md) | Defined time period for showing graph oscillations | [optional] 
 **format** | **String** | Format of the response | [optional] 

### Return type

[**AccountBalanceHistory**](AccountBalanceHistory.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/csv

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getBalanceHistoryForArrangement**
```swift
    open class func getBalanceHistoryForArrangement(arrangementId: String, dateFrom: Date? = nil, dateTo: Date? = nil, timePeriod: TimePeriod? = nil, from: Int? = nil, size: Int? = nil, cursor: String? = nil, completion: @escaping (_ data: [AccountBalanceHistoryItem]?, _ error: Error?) -> Void)
```



Retrieve balance history for single arrangement for given id.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let arrangementId = "arrangementId_example" // String | Arrangement Id
let dateFrom = Date() // Date | Bottom value of date range (optional)
let dateTo = Date() // Date | Top value of date range (optional)
let timePeriod = TimePeriod() // TimePeriod | Defined time period for showing graph oscillations (optional)
let from = 987 // Int | Page Number. Skip over pages of elements by specifying a start value for the query (optional) (default to 0)
let size = 987 // Int | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  (optional) (default to 10)
let cursor = "cursor_example" // String | Record UUID. As an alternative for specifying 'from' this allows to point to the record to start the selection from.  (optional) (default to "")

AccountsAPI.getBalanceHistoryForArrangement(arrangementId: arrangementId, dateFrom: dateFrom, dateTo: dateTo, timePeriod: timePeriod, from: from, size: size, cursor: cursor) { (response, error) in
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
 **dateFrom** | **Date** | Bottom value of date range | [optional] 
 **dateTo** | **Date** | Top value of date range | [optional] 
 **timePeriod** | [**TimePeriod**](.md) | Defined time period for showing graph oscillations | [optional] 
 **from** | **Int** | Page Number. Skip over pages of elements by specifying a start value for the query | [optional] [default to 0]
 **size** | **Int** | Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor.  | [optional] [default to 10]
 **cursor** | **String** | Record UUID. As an alternative for specifying &#39;from&#39; this allows to point to the record to start the selection from.  | [optional] [default to &quot;&quot;]

### Return type

[**[AccountBalanceHistoryItem]**](AccountBalanceHistoryItem.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, text/csv

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

