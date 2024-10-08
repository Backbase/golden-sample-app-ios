# ArrangementGroupMetadata

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**totalCount** | **Int64** |  | [optional] 
**prevCursor** | **String** | Pointer to a specific item in the dataset, its value can be use to go to previous page. When it is not returned that means there is not any previous page.  | [optional] 
**nextCursor** | **String** | Pointer to the first arrangement of the next page the group.  The consumers of the endpoint should not make any assumption about the cursor value or its structure and they should use values exclusively provided by the endpoint.  Null cursor means there is no next page.  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

