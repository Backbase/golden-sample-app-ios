import SwiftUI
import Foundation
import Combine

extension Transactions {
    
    @propertyWrapper
    public final class StatePublisher<T> {
        @Published private var value: T
        
        public var projectedValue: AnyPublisher<T, Never> {
            $value.eraseToAnyPublisher()
        }
        
        public var wrappedValue: T {
            get { value }
            set { fatalError("This property is read-only") }
        }
        
        public init(wrappedValue: T) {
            self.value = wrappedValue
        }
        
        // Internal setter method
        func set(_ newValue: T) {
            self.value = newValue
        }
    }
    
    public class State<E> {
        @StatePublisher public var isLoading: Bool = true
        @StatePublisher public var errorMessage: String?
        @StatePublisher public var transactions: [TransactionData]?
        @StatePublisher public var stateExtension: E?
        
        public init(stateExtension: E? = nil) {
            self.stateExtension = stateExtension
        }
    }
}
