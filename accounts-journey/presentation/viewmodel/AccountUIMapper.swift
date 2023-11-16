//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem
import Resolver

extension AccountsJourney.AccountsSummary {
    
    func toMapUI() -> AccountSummaryUIModel {
        
        var accountSummaryUIModel = AccountSummaryUIModel()
        if !self.customProducts.isEmpty {
            accountSummaryUIModel.customProducts =  self.customProducts.map {
                $0.mapToUi()
            }
        }
        if let currentAccounts = self.currentAccounts {
            accountSummaryUIModel.currentAccounts = currentAccounts.mapToUi()
        }
        if let savingsAccounts = self.savingsAccounts {
            accountSummaryUIModel.savingAccounts = savingsAccounts.mapToUi()
        }
        if let termDeposits = self.termDeposits {
            accountSummaryUIModel.termDeposits = termDeposits.mapToUi()
        }
        if let loans = self.loans {
            accountSummaryUIModel.loans = loans.mapToUi()
        }
        if let creditCards = self.creditCards {
            accountSummaryUIModel.creditCards = creditCards.mapToUi()
        }
        if let debitCards = self.debitCards {
            accountSummaryUIModel.debitCards = debitCards.mapToUi()
        }
        if let investmentAccounts = self.investmentAccounts {
            accountSummaryUIModel.investmentAccounts = investmentAccounts.mapToUi()
        }
        
        return accountSummaryUIModel
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
    return number ?? nil
}

extension AccountsJourney.CustomProducts {
    func mapToUi() -> AccountsUIModel {
        
        var accountsUIModel = AccountsUIModel()
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            accountsUIModel = AccountsUIModel(
                header: config.strings.generalAccountTitle(),
                products: self.products.map {
                    AccountUIModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: Currency(
                            amount: $0.bookedBalance,
                            currencyCode: $0.currency
                        ),
                        state: formatState($0.state, number: $0.productKindName),
                        isVisible: $0.visible,
                        iconName: config.design.accountIcon(.general)
                    )
                })
        }
        return accountsUIModel
    }
}

extension AccountsJourney.CurrentAccounts {
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.currentAccountTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.savingsAccountTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.termDepositTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.loanAccountTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.creditCardTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.debitCardTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
    func mapToUi() -> AccountsUIModel? {
        if !self.products.isEmpty {
            let config: AccountsJourney.Configuration = Resolver.resolve()
            return AccountsUIModel(
                header: config.strings.investmentAccountTitle(),
                products: self.products.map {
                    return AccountUIModel(
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
