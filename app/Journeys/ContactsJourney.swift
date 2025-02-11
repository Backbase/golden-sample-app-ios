//
//  ContactsJourney.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 11/02/2025.
//

import Foundation
import Resolver
import RetailContactsJourney
import RetailContactsJourneyUseCase
import AppCommon
import SwiftUI

extension RetailContactsJourney.Contacts.Configuration: AppCommon.AppDependency {
    public func register() {
        if Resolver.optional(RetailContactsUseCase.self) == nil {
            Resolver.register { RetailContactsUseCase() as ContactsUseCase }.scope(Resolver.cached)
        }
        
        Resolver.register { self }.scope(Resolver.cached)
    }
}

extension RetailContactsJourney.Contacts.Configuration: Configurable {
    static public var appDefault: RetailContactsJourney.Contacts.Configuration {
        if let configuration = Resolver.optional(RetailContactsJourney.Contacts.Configuration.self) { return configuration }
        let config = RetailContactsJourney.Contacts.Configuration()
        if Resolver.optional(ContactsUseCase.self) == nil {
            Resolver.register { RetailContactsUseCase() as ContactsUseCase }.scope(Resolver.cached)
        }
        let useCase = Resolver.resolve(ContactsUseCase.self)
        
        config.router.onTapAddContact = { navigationController in
            return {
                let vm = AddContactViewModel(useCase: useCase)
                let vc = AddContactView(vm: vm)
                let hostingController = UIHostingController(rootView: vc)
                navigationController.present(hostingController, animated: true)
            }
            
        }
        return config
    }
}
