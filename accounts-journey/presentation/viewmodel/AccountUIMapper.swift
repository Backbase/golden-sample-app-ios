//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import Resolver

extension AccountsJourney.AccountsSummary {
    
    func toMapUI() -> AccountSummaryUiModel {
        
        var accountSummaryUiModel = AccountSummaryUiModel()
        if !self.customProducts.isEmpty {
            accountSummaryUiModel.customProducts =  self.customProducts.map {
                $0.mapToUi()
            }
        }
        if let currentAccounts = self.currentAccounts {
            accountSummaryUiModel.currentAccounts = currentAccounts.mapToUi()
        }
        if let savingsAccounts = self.savingsAccounts {
            accountSummaryUiModel.savingAccounts = savingsAccounts.mapToUi()
        }
        if let termDeposits = self.termDeposits {
            accountSummaryUiModel.termDeposits = termDeposits.mapToUi()
        }
        if let loans = self.loans {
            accountSummaryUiModel.loans = loans.mapToUi()
        }
        if let creditCards = self.creditCards {
            accountSummaryUiModel.creditCards = creditCards.mapToUi()
        }
        if let debitCards = self.debitCards {
            accountSummaryUiModel.debitCards = debitCards.mapToUi()
        }
        if let investmentAccounts = self.investmentAccounts {
            accountSummaryUiModel.investmentAccounts = investmentAccounts.mapToUi()
        }
        
        return accountSummaryUiModel
    }
}
private func formatState(_ productState: AccountsJourney.ProductState?, number: String?) -> String? {
    if let state = productState?.state, let number {
        if state == "Active" {
            return number
        } else {
            return state
        }
    }
    return nil
}

extension AccountsJourney.CustomProducts {
    func mapToUi() -> AccountsUiModel {
        
        var accountsUiModel = AccountsUiModel()
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            accountsUiModel = AccountsUiModel(
                header: config.strings.generalAccountTitle(),
                products: self.products.map {
                    AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.iban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.general)
                    )
                })
        }
        return accountsUiModel
    }
}

extension AccountsJourney.CurrentAccounts {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.currentAccountTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.current)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.SavingsAccounts {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.savingsAccountTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.savings)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.TermDeposits {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.termDepositTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.termDeposit)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.Loans {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.loanAccountTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.loan)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.CreditCards {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.creditCardTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.number),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.creditCard)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.DebitCards {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.debitCardTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance:  Currency(
                            amount: String($0.reservedAmount ?? 0),
                            currencyCode: nil
                        ),
                        state: formatState($0.state, number: $0.number),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.debitCard)
                    )
                })
        } else {
            return nil
        }
    }
}

extension AccountsJourney.InvestmentAccounts {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUiModel(
                header: config.strings.investmentAccountTitle(),
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: String($0.reservedAmount ?? 0),
                            currencyCode: nil
                        ),
                        state: formatState($0.state, number: $0.iban ?? $0.bban),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.investment)
                    )
                })
        } else {
            return nil
        }
    }
}
