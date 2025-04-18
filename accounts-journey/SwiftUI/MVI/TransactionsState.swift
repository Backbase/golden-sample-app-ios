import SwiftUI
import Foundation

extension Transactions {
    
    @Observable
    public class State {
        public var isLoading: Bool = true
        public var errorMessage: String?
        public var data: [TransactionData]?
        
        public init() {}
    }
}
