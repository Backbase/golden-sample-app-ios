import ArrangementsClient2Gen2
import BackbaseDesignSystem
import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Account ordering

@Suite("AccountsListOrdering")
struct AccountsListOrderingTests {

    private func account(_ id: String, _ name: String? = nil) -> AccountData {
        AccountData(id: id, name: name)
    }

    @Test
    func orderedAccounts_keepsTheKindOrder_andPutsCustomProductsLast() {
        let summary = AccountSummaryData(
            customProducts: [AccountsData(products: [account("custom")])],
            currentAccounts: AccountsData(products: [account("current")]),
            savingAccounts: AccountsData(products: [account("savings")]),
            termDeposits: AccountsData(products: [account("deposit")]),
            loans: AccountsData(products: [account("loan"), account("unnamed")]),
            creditCards: AccountsData(products: [account("credit")]),
            debitCards: AccountsData(products: [account("debit")]),
            investmentAccounts: AccountsData(products: [account("investment")])
        )

        #expect(AccountsListOrdering.orderedAccounts(from: summary).map(\.id) == [
            "current", "savings", "deposit", "loan", "unnamed", "credit", "debit", "investment", "custom"
        ])
    }

    @Test
    func orderedAccounts_keepsEveryCustomProductKind_inOrder() {
        let summary = AccountSummaryData(customProducts: [
            AccountsData(products: [account("first")]),
            AccountsData(products: [account("second"), account("third")])
        ])

        #expect(AccountsListOrdering.orderedAccounts(from: summary).map(\.id) == ["first", "second", "third"])
    }

    @Test
    func orderedAccounts_isEmpty_forAnEmptySummary() {
        #expect(AccountsListOrdering.orderedAccounts(from: AccountSummaryData()).isEmpty)
    }
}

// MARK: - Product summary mapping

@Suite("ProductSummary mapping")
struct ProductSummaryDataMapperTests {

    private let configuration = AccountsJourney.Configuration()

    @Test
    func mapping_buildsEveryKindWithItsHeaderAndProducts() throws {
        let summary = try ProductSummary.fixture().toMapUI(configuration: configuration)
        let strings = AccountsList.Strings()

        #expect(summary.currentAccounts?.header == strings.currentAccountTitle())
        #expect(summary.currentAccounts?.products.map(\.id) == ["current-1"])
        #expect(summary.savingAccounts?.header == strings.savingsAccountTitle())
        #expect(summary.loans?.header == strings.loanAccountTitle())
        #expect(summary.customProducts?.count == 1)
        #expect(summary.customProducts?.first?.header == strings.generalAccountTitle())
        #expect(summary.termDeposits == nil)
        #expect(summary.creditCards == nil)
        #expect(summary.debitCards == nil)
        #expect(summary.investmentAccounts == nil)
    }

    @Test
    func mapping_keepsEveryAccountField() throws {
        let account = try #require(ProductSummary.fixture().toMapUI(configuration: configuration).currentAccounts?.products.first)

        #expect(account.id == "current-1")
        #expect(account.name == "Main account")
        #expect(account.balance == Currency(amount: "1250.50", currencyCode: "EUR"))
        #expect(account.isVisible == true)
    }

    @Test
    func mapping_showsTheNumber_forActiveAccounts_andTheStateOtherwise() throws {
        let summary = try ProductSummary.fixture().toMapUI(configuration: configuration)

        #expect(summary.currentAccounts?.products.first?.state == "BBAN-1")
        #expect(summary.loans?.products.first?.state == "Closed")
    }

    @Test
    func mapping_dropsEmptyKinds() throws {
        let summary = try ProductSummary.decode(#"{"currentAccounts": {"products": []}, "customProductKinds": [{"products": []}]}"#)
            .toMapUI(configuration: configuration)

        #expect(summary.currentAccounts == nil)
        #expect(summary.customProducts?.first?.products.isEmpty == true)
        #expect(AccountsListOrdering.orderedAccounts(from: summary).isEmpty)
    }

    @Test
    func orderedAccounts_keepsTheKindOrder_ofTheMappedSummary() throws {
        let summary = try ProductSummary.fixture().toMapUI(configuration: configuration)

        #expect(AccountsListOrdering.orderedAccounts(from: summary).map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
    }

    @Test
    func mapping_usesTheIconOfTheDesign() throws {
        var configuration = AccountsJourney.Configuration()
        configuration.design.accountIcon = { _ in
            AccountIconInfo(icon: UIImage(), backgroundColor: .green)
        }

        let account = try #require(ProductSummary.fixture().toMapUI(configuration: configuration).currentAccounts?.products.first)

        #expect(account.iconName?.backgroundColor == UIColor.green)
    }
}
