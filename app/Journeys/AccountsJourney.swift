//
//  AccountsJourney.swift
//  GoldenSampleApp
//
//  Created by Backbase on 04/02/2025.
//

import AccountsJourney
import AppCommon
import Resolver
import ArrangementsClient2Gen2
import GoldenAccountsUseCase

extension AccountsJourney.Configuration: AppCommon.AppDependency {
    public func register() {
        if Resolver.optional(AccountsListUseCase.self) == nil  {
            let productSummaryClient = clientFactory(defaultClient: ArrangementsClient2Gen2.ProductSummaryAPI(), clientPath: "api/arrangement-manager")
            Resolver.register { AccountsListSummaryUseCaseImp(client: productSummaryClient) as AccountsListUseCase }
        }
        if Resolver.optional(AccountDetailsUseCase.self) == nil {
            let arrangementsClient = clientFactory(defaultClient: ArrangementsClient2Gen2.ArrangementsAPI(), clientPath: "api/arrangement-manager")
            
            Resolver.register { AccountDetailUseCaseImp(client: arrangementsClient) as AccountDetailsUseCase}
        }
        
        
        Resolver.register { self }.scope(Resolver.cached)
    }
}

extension AccountsJourney.Configuration: AppCommon.Configurable {
    static public var appDefault: AccountsJourney.Configuration {
        if let configuration = Resolver.optional(AccountsJourney.Configuration.self) { return configuration }
        let configuration = AccountsJourney.Configuration()
        return configuration
    }
}
