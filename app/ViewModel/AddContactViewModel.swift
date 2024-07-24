//
//  AddContactViewModel.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 24/07/2024.
//

import Foundation
import RetailContactsJourney

enum AddContactViewState {
    case loading
    case contactAdded
    case hasError
    case idle
}

final class AddContactViewModel: ObservableObject {
    private let useCase: ContactsUseCase
    @Published var state: AddContactViewState = .idle
    
    init(useCase: ContactsUseCase) {
        self.useCase = useCase
    }
    func addContact(name: String, accountNumber: String){
        let requestParameters = CreateContactRequestParameters(name: name, identifiers: [.init(value: accountNumber, type: .accountNumber)])
        state = .loading
        useCase.createContact(parameters: requestParameters) {[weak self] result in
            switch result {
            case .success:
                self?.state = .contactAdded
            case .failure:
                self?.state = .hasError
            }
        }
    }
}