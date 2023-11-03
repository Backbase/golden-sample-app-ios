//
//  AccountUIMapper.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 03/11/2023.
//

import Foundation
import BackbaseDesignSystem

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

private func formatCurrency(currency: String?, amount: String?) -> String? {
    var options = DesignSystem.Formatting.Options()
//    options.formattingStyle = .currencyISOCode
    options.customCode = currency
    options.showsPlusSign = true
    options.abbreviator = DesignSystem.shared.formatting.abbreviators.default
    
    let formatter = DesignSystem.Formatting.makeFormatter()
    let formattedAmount = formatter.format(amount: Decimal(string: amount ?? "0.00") ?? 0, options: options)
    return formattedAmount
}

extension AccountsJourney.CustomProducts {
    func mapToUi() -> AccountsUiModel {
        var accountsUiModel = AccountsUiModel()
        if !self.products.isEmpty {
            accountsUiModel = AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        iban: $0.iban ?? $0.bban ?? $0.bic,
                        isVisible: $0.visible
                    )
                })
        }
        return accountsUiModel
    }
}

extension AccountsJourney.CurrentAccounts {
    func mapToUi() -> AccountsUiModel? {
        if !self.products.isEmpty {
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        iban: $0.bban ?? $0.iban ?? $0.bic,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban ?? $0.bic),
                        iban: $0.bban ?? $0.iban ?? $0.bic,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban),
                        iban: $0.bban ?? $0.iban ,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: formatState($0.state, number: $0.bban ?? $0.iban),
                        iban: $0.bban ?? $0.iban ,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.bookedBalance,
                            amount: $0.currency
                        ),
                        state: $0.state?.state,
                        iban: $0.number ,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance:  formatCurrency(
                            currency: nil,
                            amount:String($0.reservedAmount ?? 0)
                        ),
                        state: formatState($0.state, number: $0.number),
                        iban: $0.number ,
                        isVisible: $0.visible
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
            return AccountsUiModel(
                header: self.name ?? "",
                products: self.products.map {
                    return AccountUiModel(
                        id: $0.identifier,
                        name: $0.name,
                        balance: formatCurrency(
                            currency: $0.currency,
                            amount:String($0.reservedAmount ?? 0)
                        ),
                        state: formatState($0.state, number: $0.iban ?? $0.bban),
                        iban: $0.iban ?? $0.bban ,
                        isVisible: $0.visible
                    )
                })
        } else {
            return nil
        }
    }
}
