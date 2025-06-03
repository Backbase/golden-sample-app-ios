import SwiftUI
import Foundation

public enum TransactionsState<T, DataType> {
    public struct LoadingData {
        public init(stateExtension: DataType? = nil) {
            self.stateExtension = stateExtension
        }
        
        public let stateExtension: DataType?
    }
    
    public struct LoadedData {
        public init(transactions: [TransactionData], stateExtension: DataType? = nil) {
            self.transactions = transactions
            self.stateExtension = stateExtension
        }
        
        public let transactions: [TransactionData]
        public let stateExtension: DataType?
    }
    
    public struct ErrorData {
        public init(errorMessage: String, stateExtension: DataType? = nil) {
            self.errorMessage = errorMessage
            self.stateExtension = stateExtension
        }
        
        public let errorMessage: String
        public let stateExtension: DataType?
    }

    case loading(LoadingData)
    case error(ErrorData)
    case loaded(LoadedData)
    case custom(T)
    
    public var stateExtension: DataType? {
        switch self {
        case .loading(let data):
            return data.stateExtension
        case .error(let data):
            return data.stateExtension
        case .loaded(let data):
            return data.stateExtension
        case .custom(let customState):
            return nil // Custom state does not have a defined extension
        }
    }
//    public let isLoading: Bool
//    public let errorMessage: String?
//    public let transactions: [TransactionData]?

//    public let stateExtension: T?

//    public init(isLoading: Bool, errorMessage: String?, transactions: [TransactionData]?, stateExtension: T?) {
//        self.isLoading = isLoading
//        self.errorMessage = errorMessage
//        self.transactions = transactions
//        self.stateExtension = stateExtension
//    }

    public static var initial: TransactionsState<T, DataType> {
        .loading(LoadingData(stateExtension: nil))
    }
}
