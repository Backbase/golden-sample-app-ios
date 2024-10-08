# ProductKindsAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getProductKinds**](ProductKindsAPI.md#getproductkinds) | **GET** /client-api/v2/product-kinds | 


# **getProductKinds**
```swift
    open class func getProductKinds(contentLanguage: String? = nil, completion: @escaping (_ data: ProductKindsResult?, _ error: Error?) -> Void)
```



Gets list of product kinds to which the user has access and visible.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let contentLanguage = "contentLanguage_example" // String | Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)

ProductKindsAPI.getProductKinds(contentLanguage: contentLanguage) { (response, error) in
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

### Return type

[**ProductKindsResult**](ProductKindsResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

