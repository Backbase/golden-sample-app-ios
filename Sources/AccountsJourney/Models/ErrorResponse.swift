//
//  ErrorResponse.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 12/10/2023.
//

import Foundation

public struct ErrorResponse: Swift.Error, Equatable{
    /// Status code of the error
    public let statusCode: Int?
    /// Response data
    public let data: Data?
    /// Error
    public let error: Swift.Error?
    
    /**
     * Initialiser for the `ErrorResponse` DTO.
     * - Parameters statusCode: Status code of the error
     * - Parameters data: Response data.
     * - Parameters error: Error
     * - returns initialised `ErrorResponse` object.
     */
    public init(statusCode: Int? = nil, data: Data? = nil, error: Swift.Error? = nil) {
        self.statusCode = statusCode
        self.data = data
        self.error = error
    }
    
    public static func == (lhs: ErrorResponse, rhs: ErrorResponse) -> Bool {
        return lhs.statusCode == rhs.statusCode &&
        lhs.data == rhs.data &&
        lhs.error?.localizedDescription == rhs.error?.localizedDescription
    }
}