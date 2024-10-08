# ArrangementViewsAPI

All URIs are relative to *http://localhost:4010*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getArrangementView**](ArrangementViewsAPI.md#getarrangementview) | **GET** /client-api/v2/arrangement-views/{viewName} | 
[**getArrangementViewGroup**](ArrangementViewsAPI.md#getarrangementviewgroup) | **GET** /client-api/v2/arrangement-views/{viewName}/groups/{groupName} | 


# **getArrangementView**
```swift
    open class func getArrangementView(viewName: String, filter: String? = nil, limit: Int? = nil, cursor: String? = nil, sort: [String]? = nil, completion: @escaping (_ data: ArrangementViewResponse?, _ error: Error?) -> Void)
```



Provide a named view of the arrangement.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let viewName = "viewName_example" // String | the name of the view that should be returned
let filter = "filter_example" // String | Encoded filtering expression that is applied to the arrangements collection.  The filter is applied to all groups that are defined in the view. The response contains all arrangements retained in each group. The arrangements are returned as a single group irrespective of the number of arrangements in the result. Only the first page is returned, as defined by the default group limit configuration, but the consumers of the endpoint can use pagination which is activated only when filtering is enabled.  The filter is a logical combination of simple expressions that verifies the attributes of the arrangements.  A simple expression is a relational predicate that has the form:  ``` <PATH> <OP> <CONSTANTS> ```  ... where:  * **PATH**: the attribute path, e.g. `productKind.kindUri` * **OP**: relational operator as described below * **CONSTANT**: one ore more constants values, depending on the operator  The operator can be one of the following:  * **`=`**: to test for equality or whether the value is a proper subset of the given array * **`!`**: the oposite of `=` * **`<`, `<=`, `>=`, `>`**: to test for comparison  For a complete description of the expression syntax, check the community documentation.  **NOTE**: this parameter must be URL encoded.  (optional)
let limit = 987 // Int | Limit the number of elements on the response. Default value will be taken from configuration.  **NOTE**: pagination is active only with filtering.  (optional)
let cursor = "cursor_example" // String | Pointer to the first record of the page that is going to be returned by the endpoint.  The pointer must be taken from the cursor of a previous call of the endpoint.  The endpoint returns a status of 403 (forbidden) if the cursor is invalid or if there is no arrangement that corresponds to the given cursor, with a key `account.api.arrangement.notEntitledToSee`.  **NOTE**: pagination is active only with filtering.  (optional)
let sort = ["inner_example"] // [String] | Mapped attribute names by which arrangements will be sorted. Prefix the name with minus (-) sign to sort in descending order.  (optional)

ArrangementViewsAPI.getArrangementView(viewName: viewName, filter: filter, limit: limit, cursor: cursor, sort: sort) { (response, error) in
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
 **viewName** | **String** | the name of the view that should be returned | 
 **filter** | **String** | Encoded filtering expression that is applied to the arrangements collection.  The filter is applied to all groups that are defined in the view. The response contains all arrangements retained in each group. The arrangements are returned as a single group irrespective of the number of arrangements in the result. Only the first page is returned, as defined by the default group limit configuration, but the consumers of the endpoint can use pagination which is activated only when filtering is enabled.  The filter is a logical combination of simple expressions that verifies the attributes of the arrangements.  A simple expression is a relational predicate that has the form:  &#x60;&#x60;&#x60; &lt;PATH&gt; &lt;OP&gt; &lt;CONSTANTS&gt; &#x60;&#x60;&#x60;  ... where:  * **PATH**: the attribute path, e.g. &#x60;productKind.kindUri&#x60; * **OP**: relational operator as described below * **CONSTANT**: one ore more constants values, depending on the operator  The operator can be one of the following:  * **&#x60;&#x3D;&#x60;**: to test for equality or whether the value is a proper subset of the given array * **&#x60;!&#x60;**: the oposite of &#x60;&#x3D;&#x60; * **&#x60;&lt;&#x60;, &#x60;&lt;&#x3D;&#x60;, &#x60;&gt;&#x3D;&#x60;, &#x60;&gt;&#x60;**: to test for comparison  For a complete description of the expression syntax, check the community documentation.  **NOTE**: this parameter must be URL encoded.  | [optional] 
 **limit** | **Int** | Limit the number of elements on the response. Default value will be taken from configuration.  **NOTE**: pagination is active only with filtering.  | [optional] 
 **cursor** | **String** | Pointer to the first record of the page that is going to be returned by the endpoint.  The pointer must be taken from the cursor of a previous call of the endpoint.  The endpoint returns a status of 403 (forbidden) if the cursor is invalid or if there is no arrangement that corresponds to the given cursor, with a key &#x60;account.api.arrangement.notEntitledToSee&#x60;.  **NOTE**: pagination is active only with filtering.  | [optional] 
 **sort** | [**[String]**](String.md) | Mapped attribute names by which arrangements will be sorted. Prefix the name with minus (-) sign to sort in descending order.  | [optional] 

### Return type

[**ArrangementViewResponse**](ArrangementViewResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getArrangementViewGroup**
```swift
    open class func getArrangementViewGroup(viewName: String, groupName: String, filter: String? = nil, limit: Int? = nil, cursor: String? = nil, sort: [String]? = nil, completion: @escaping (_ data: ArrangementGroupResponse?, _ error: Error?) -> Void)
```



Provide a named group containing arrangements.

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import ArrangementsApi

let viewName = "viewName_example" // String | the name of the view that should be returned
let groupName = "groupName_example" // String | the name of the group that should be returned
let filter = "filter_example" // String | Encoded filtering expression that is applied to the arrangements collection.  The filter is applied to all groups that are defined in the view. The response contains all arrangements retained in each group. The arrangements are returned as a single group irrespective of the number of arrangements in the result. Only the first page is returned, as defined by the default group limit configuration.  The filter is a logical combination of simple expressions that verifies the attributes of the arrangements.  A simple expression is a relational predicate that has the form:  ``` <PATH> <OP> <CONSTANTS> ```  ... where:  * **PATH**: the attribute path, e.g. `productKind.kindUri` * **OP**: relational operator as described below * **CONSTANT**: one or more constants values, depending on the operator  The operator can be one of the following:  * **`=`**: to test for equality or whether the value is a proper subset of the given array * **`!`**: the oposite of `=` * **`<`, `<=`, `>=`, `>`**: to test for comparison  For a complete description of the expression syntax, check the community documentation.  **NOTE**: this parameter must be URL encoded.  (optional)
let limit = 987 // Int | Limit the number of elements on the response. Default value will be taken from configuration. (optional)
let cursor = "cursor_example" // String | Pointer to the first record of the page that is going to be returned by the endpoint.  The pointer must be taken from the cursor of a previous call of the endpoint.  The endpoint returns a status of 403 (forbidden) if the cursor is invalid or if there is no arrangement that corresponds to the given cursor, with a key `account.api.arrangement.notEntitledToSee`.  (optional)
let sort = ["inner_example"] // [String] | Mapped attribute names by which arrangements will be sorted. Prefix the name with minus (-) sign to sort in descending order.  (optional)

ArrangementViewsAPI.getArrangementViewGroup(viewName: viewName, groupName: groupName, filter: filter, limit: limit, cursor: cursor, sort: sort) { (response, error) in
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
 **viewName** | **String** | the name of the view that should be returned | 
 **groupName** | **String** | the name of the group that should be returned | 
 **filter** | **String** | Encoded filtering expression that is applied to the arrangements collection.  The filter is applied to all groups that are defined in the view. The response contains all arrangements retained in each group. The arrangements are returned as a single group irrespective of the number of arrangements in the result. Only the first page is returned, as defined by the default group limit configuration.  The filter is a logical combination of simple expressions that verifies the attributes of the arrangements.  A simple expression is a relational predicate that has the form:  &#x60;&#x60;&#x60; &lt;PATH&gt; &lt;OP&gt; &lt;CONSTANTS&gt; &#x60;&#x60;&#x60;  ... where:  * **PATH**: the attribute path, e.g. &#x60;productKind.kindUri&#x60; * **OP**: relational operator as described below * **CONSTANT**: one or more constants values, depending on the operator  The operator can be one of the following:  * **&#x60;&#x3D;&#x60;**: to test for equality or whether the value is a proper subset of the given array * **&#x60;!&#x60;**: the oposite of &#x60;&#x3D;&#x60; * **&#x60;&lt;&#x60;, &#x60;&lt;&#x3D;&#x60;, &#x60;&gt;&#x3D;&#x60;, &#x60;&gt;&#x60;**: to test for comparison  For a complete description of the expression syntax, check the community documentation.  **NOTE**: this parameter must be URL encoded.  | [optional] 
 **limit** | **Int** | Limit the number of elements on the response. Default value will be taken from configuration. | [optional] 
 **cursor** | **String** | Pointer to the first record of the page that is going to be returned by the endpoint.  The pointer must be taken from the cursor of a previous call of the endpoint.  The endpoint returns a status of 403 (forbidden) if the cursor is invalid or if there is no arrangement that corresponds to the given cursor, with a key &#x60;account.api.arrangement.notEntitledToSee&#x60;.  | [optional] 
 **sort** | [**[String]**](String.md) | Mapped attribute names by which arrangements will be sorted. Prefix the name with minus (-) sign to sort in descending order.  | [optional] 

### Return type

[**ArrangementGroupResponse**](ArrangementGroupResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

