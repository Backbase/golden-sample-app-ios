import ArrangementsClient2Gen2
import BackbaseDesignSystem
import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Account summary

@Suite("AccountSummaryUIModel")
struct AccountSummaryUIModelTests {

    private func account(_ id: String, _ name: String?) -> AccountUIModel {
        AccountUIModel(id: id, name: name)
    }

    private var summary: AccountSummaryUIModel {
        AccountSummaryUIModel(
            customProducts: [AccountsUIModel(products: [account("custom", "Custom")])],
            currentAccounts: AccountsUIModel(products: [account("current", "Main")]),
            savingAccounts: AccountsUIModel(products: [account("savings", "Savings")]),
            loans: AccountsUIModel(products: [account("loan", "Car loan"), account("unnamed", nil)])
        )
    }

    private struct SearchCase: CustomTestStringConvertible, Sendable {
        let name: String
        let query: String
        let expectedIDs: [String]

        var testDescription: String { name }
    }

    @Test
    func generateList_keepsTheKindOrder_andPutsCustomProductsLast() {
        #expect(summary.generateList().map(\.id) == ["current", "savings", "loan", "unnamed", "custom"])
    }

    @Test("generateList filters by name", arguments: [
        SearchCase(name: "ignores case and surrounding whitespace", query: "  SAV ", expectedIDs: ["savings"]),
        // "a" is in "Main", "Savings" and "Car loan", not in "Custom"; the unnamed account never matches.
        SearchCase(name: "skips accounts without a name", query: "a", expectedIDs: ["current", "savings", "loan"]),
        SearchCase(name: "is empty when nothing matches", query: "xyz", expectedIDs: [])
    ])
    private func generateList_filtersByName(_ searchCase: SearchCase) {
        #expect(summary.generateList(query: searchCase.query).map(\.id) == searchCase.expectedIDs)
    }

    @Test
    func generateList_isEmpty_forAnEmptySummary() {
        #expect(AccountSummaryUIModel().generateList().isEmpty)
    }
}

// MARK: - Product summary mapping

@Suite("ProductSummary mapping")
struct ProductSummaryUIMapperTests {

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
        #expect(summary.generateList().isEmpty)
    }

    @Test
    func generateList_keepsTheKindOrder_ofTheMappedSummary() throws {
        let summary = try ProductSummary.fixture().toMapUI(configuration: configuration)

        #expect(summary.generateList().map(\.id) == ["current-1", "savings-1", "loan-1", "custom-1"])
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
