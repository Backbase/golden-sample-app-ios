//
//  MockAccountDetailsUseCase.swift
//  SnapshotTests
//

import AccountsJourney
import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation

/// An `AccountDetailsUseCase` that answers from a bundled JSON file, fails, or never answers,
/// so that every state of the screen can be reached deterministically.
final class MockAccountDetailsUseCase: AccountDetailsUseCase {

    enum Behaviour {
        /// Decodes the JSON file with the given name from the test bundle.
        case success(fileName: String = "arrangement.json")
        case failure
        /// Never calls the completion, which keeps the screen loading.
        case neverCompletes
    }

    private let behaviour: Behaviour

    init(_ behaviour: Behaviour = .success()) {
        self.behaviour = behaviour
    }

    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountArrangementItem, ErrorResponse>) -> Void
    ) {
        switch behaviour {
        case let .success(fileName):
            do {
                let data = Bundle.data(from: fileName)
                completion(.success(try JSONDecoder().decode(AccountArrangementItem.self, from: data)))
            } catch {
                completion(.failure(.error(0, nil, error)))
            }
        case .failure:
            completion(.failure(.error(500, nil, AccountDetails.Error.invalidResponse)))
        case .neverCompletes:
            break
        }
    }
}
