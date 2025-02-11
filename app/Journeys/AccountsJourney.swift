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
        Resolver.register { CustomAccountListSummaryUseCaseImpl() as AccountsListUseCase}
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
