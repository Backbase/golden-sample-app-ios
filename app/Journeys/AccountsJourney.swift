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

extension AccountsJourney.Configuration: AppCommon.AppDependency {
    public func register() {
        let productSummaryClient = clientFactory(defaultClient: ArrangementsClient2Gen2.ProductSummaryAPI(), clientPath: "api/arrangement-manager")
        
        let arrangementsClient = clientFactory(defaultClient: ArrangementsClient2Gen2.ArrangementsAPI(), clientPath: "api/arrangement-manager")
        
        Resolver.register { AccountsListSummaryUseCaseImp(client: productSummaryClient) as AccountsListUseCase }
        Resolver.register { AccountDetailUseCaseImp(client: arrangementsClient) as AccountDetailsUseCase}
        
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
