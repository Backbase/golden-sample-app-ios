//
// ProductKindsAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Backbase
import ClientCommonGen2

/// ProductKindsAPI protocol defines a blueprint of methods, properties, and other requirements for ProductKindsAPI functionality. 
public protocol ProductKindsAPIProtocol {

    /**
     - GET /client-api/v2/product-kinds
     - Gets list of product kinds to which the user has access and visible.
     - parameter contentLanguage: (header) Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
     - returns: Call<ProductKindsResult> 
     */
    @available(*, deprecated, message: "This method is deprecated in favor of the alternative method with ProductKindsAPI.GetProductKindsRequestParams class.")
    func getProductKindsCall(contentLanguage: String?) throws -> Call<ProductKindsResult>
    
    /**
     - GET /client-api/v2/product-kinds
     - Gets list of product kinds to which the user has access and visible.

     - parameter params: The request parameters of this request.
     - returns: Call<ProductKindsResult> 
     */
    func getProductKindsCall(params: ProductKindsAPI.GetProductKindsRequestParams) throws -> Call<ProductKindsResult>
}


public class ProductKindsAPI: NSObject, DBSClient, ProductKindsAPIProtocol {
    public var dataProvider: DBSDataProvider?
    public var baseURL: URL

    public override init() {
        self.baseURL = URL(fileURLWithPath: "")
    }

    required public init(dataProvider: DBSDataProvider, baseURL: URL) {
        self.dataProvider = dataProvider
        self.baseURL = baseURL
    }
    /**
     - GET /client-api/v2/product-kinds
     - Gets list of product kinds to which the user has access and visible.
     - parameter contentLanguage: (header) Defines the translation natural language as specified in ISO 639-1, and territory two-letter form of ISO 3166. (optional)
     - returns: Call<ProductKindsResult> 
     */
     @available(*, deprecated, message: "This method is deprecated in favor of the alternative method with ProductKindsAPI.GetProductKindsRequestParams class.")
    open func getProductKindsCall(contentLanguage: String? = nil) throws -> Call<ProductKindsResult> {
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
        let path = "/client-api/v2/product-kinds"
        
        let parameters: [String: Any]? = nil
        
        let urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        let nillableHeaders: [String: Any?] = [
            "Content-Language":contentLanguage?.encodeToJSON()
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)
        guard let url = urlComponents?.url else { throw CallError.invalidUrl }
        let request = try ClientCommonGen2.RequestBuilder.createURLRequest(requestUrl: url, 
                                                                            method: "GET",
                                                                            queryParameters: nil,
                                                                            bodyParameters: parameters,
                                                                            bodyType: .none,
                                                                            headers: headerParameters)
        return Call<ProductKindsResult>(dataProvider: dataProvider, request: request)
    }

    /**
     - GET /client-api/v2/product-kinds
     - Gets list of product kinds to which the user has access and visible.

     - parameter params: The request parameters of this request.
     - returns: Call<ProductKindsResult> 
     */
    open func getProductKindsCall(params: ProductKindsAPI.GetProductKindsRequestParams) throws -> Call<ProductKindsResult> {
        guard let dataProvider = dataProvider else { throw CallError.missingDataProvider }
        let path = "/client-api/v2/product-kinds"
        
        let parameters: [String: Any]? = nil
        
        let urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        let nillableHeaders: [String: Any?] = [
            "Content-Language": params.contentLanguage?.encodeToJSON()
        ]
        let headerParameters = APIHelper.rejectNilHeaders(nillableHeaders)
        guard let url = urlComponents?.url else { throw CallError.invalidUrl }
        let request = try ClientCommonGen2.RequestBuilder.createURLRequest(requestUrl: url, 
                                                                            method: "GET",
                                                                            queryParameters: nil,
                                                                            bodyParameters: parameters,
                                                                            bodyType: .none,
                                                                            headers: headerParameters)
        return Call<ProductKindsResult>(dataProvider: dataProvider, request: request)
    }
}
