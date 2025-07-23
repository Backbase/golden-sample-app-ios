//
//  RetailPayment.swift
//  ios-golden-sample-app
//
//  Created by George Nyakundi on 22/07/2025.
//

import RetailPaymentJourney
//import PaymentOrderClient3Gen2
import RetailPaymentJourneyPaymentOrdersUseCase
import RetailPaymentJourneyAccountArrangementsUseCase
import RetailPaymentJourneyContactsUseCase
import AppCommon
import Resolver

extension RetailPayment.Configuration: AppCommon.AppDependency {
    public func register() {
        // CreatePaymentOrderUseCase
        if Resolver.optional(CreatePaymentOrderUseCase.self) == nil {
            // Register the default
            Resolver.register { RetailCreatePaymentOrderUseCase() as CreatePaymentOrderUseCase }
        }
        
        // GetPaymentPartiesServiceUseCase
        if Resolver.optional(GetPaymentPartiesServiceUseCase.self) == nil {
            Resolver.register { RetailGetPaymentPartiesServiceUseCase() as GetPaymentPartiesServiceUseCase }
        }
        
        // ContactsUseCase
        if Resolver.optional(ContactsUseCase.self) == nil {
            Resolver.register { RetailContactsUseCase() as ContactsUseCase }
        }
        
        Resolver.register { self }.scope(Resolver.cached)
    }
}

extension RetailPayment.Configuration: AppCommon.Configurable {
    static public var appDefault: RetailPayment.Configuration {
        if let configuration = Resolver.optional(RetailPayment.Configuration.self) {
            return configuration
        }
        guard let createPaymentOrderUseCare = Resolver.optional(CreatePaymentOrderUseCase.self),
              let getPaymentPartiesUseCase = Resolver.optional(GetPaymentPartiesServiceUseCase.self),
              let contactsUseCase = Resolver.optional(ContactsUseCase.self) else {
            
            let retailContactsUseCase = RetailContactsUseCase()
            let getPaymentPartiesServiceUseCase = RetailGetPaymentPartiesServiceUseCase()
            let createPaymentOrderUseCase = RetailCreatePaymentOrderUseCase()
            
            return RetailPayment.Configuration(
                createPaymentOrderUseCase: createPaymentOrderUseCase,
                getPaymentPartiesUseCase: getPaymentPartiesServiceUseCase,
                contactsUseCase: retailContactsUseCase
            )
        }
        let configuration = RetailPayment.Configuration(
            createPaymentOrderUseCase: createPaymentOrderUseCare,
            getPaymentPartiesUseCase: getPaymentPartiesUseCase,
            contactsUseCase: contactsUseCase)
        return configuration
    }
}
