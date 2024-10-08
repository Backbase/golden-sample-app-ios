# ArrangementGroupVariant

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | One of the following - but not limited to - these values:    - BOOLEAN   - INTEGER   - DECIMAL   - STRING   - DATE   - DATETIME    - COLLECTION  | [optional] [default to "STRING"]
**key** | **String** | An optional attribute providing additional information about the attribute, like the I18N key or the original attribute name.  The value can be configured in the backend for each attribute. If there is no such configuration it defaults to the original attribute name.  | [optional] 
**value** | **String** | The string representation of the variant value, when the variant type is a simple type. | [optional] 
**elements** | [ArrangementGroupElement] | A collection of group elements which is filled in, when the variant type is of type COLLECTION.  The elements are tipically child attributes of an arrangement, such as debit cards or subscriptions.  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)

