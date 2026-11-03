//
//  MockAccountsListUseCase.swift
//  SnapshotTests
//

import AccountsJourney
import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// An `AccountsListUseCase` that answers from a bundled JSON file, fails, or never answers,
/// so that every state of the screen can be reached deterministically.
final class MockAccountsListUseCase: AccountsListUseCase {

    enum Behaviour {
        /// Decodes the JSON file with the given name from the test bundle.
        case success(fileName: String = "accounts_summary.json")
        /// Answers with a summary that has no products.
        case empty
        case failure
        /// Never calls the completion, which keeps the screen loading.
        case neverCompletes
    }

    private let behaviour: Behaviour

    init(_ behaviour: Behaviour = .success()) {
        self.behaviour = behaviour
    }

    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ErrorResponse>) -> Void) {
        switch behaviour {
        case let .success(fileName):
            completion(decode(Bundle.data(from: fileName)))
        case .empty:
            completion(decode(Data("{}".utf8)))
        case .failure:
            completion(.failure(.error(500, nil, AccountsList.Error.invalidResponse)))
        case .neverCompletes:
            break
        }
    }

    private func decode(_ data: Data) -> Result<ProductSummary, ErrorResponse> {
        do {
            return .success(try JSONDecoder().decode(ProductSummary.self, from: data))
        } catch {
            return .failure(.error(0, nil, error))
        }
    }
}
