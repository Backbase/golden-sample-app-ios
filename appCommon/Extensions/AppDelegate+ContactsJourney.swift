//
//  AppDelegate+ContactsJourney.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V.  on 22/07/2024.
//

import Foundation
import Resolver
import RetailContactsJourney
import RetailContactsJourneyUseCase
import SwiftUI

extension AppDelegate {
    func setupContactsJourney() {
        let useCase = RetailContactsUseCase()
        let config = RetailContactsJourney.Contacts.Configuration()
        
        config.router.onTapAddContact = { navigationController in
            return {
                let vm = AddContactViewModel(useCase: useCase)
                let vc = AddContactView(vm: vm)
                let hostingController = UIHostingController(rootView: vc)
                navigationController.present(hostingController, animated: true)
            }
        }
        
        Resolver.register { config as RetailContactsJourney.Contacts.Configuration }
        Resolver.register { useCase as ContactsUseCase}
    }
}
