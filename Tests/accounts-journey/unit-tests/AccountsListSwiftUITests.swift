import XCTest
import UIKit
import Resolver
import ArrangementsClient2Gen2
import ClientCommonGen2
import BackbaseDesignSystem
@testable import AccountsJourney

// MARK: - Account summary

final class AccountSummaryUIModelTests: XCTestCase {

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

    func test_generateList_keepsTheKindOrder_andPutsCustomProductsLast() {
        XCTAssertEqual(summary.generateList().map(\.id), ["current", "savings", "loan", "unnamed", "custom"])
    }

    func test_generateList_filtersByName_ignoringCaseAndSurroundingWhitespace() {
        XCTAssertEqual(summary.generateList(query: "  SAV ").map(\.id), ["savings"])
    }

    func test_generateList_skipsAccountsWithoutAName_whenSearching() {
        // "a" is in "Main", "Savings" and "Car loan", not in "Custom"; the unnamed account never matches.
        XCTAssertEqual(summary.generateList(query: "a").map(\.id), ["current", "savings", "loan"])
    }

    func test_generateList_isEmpty_whenNothingMatches() {
        XCTAssertTrue(summary.generateList(query: "xyz").isEmpty)
    }

    func test_generateList_isEmpty_forAnEmptySummary() {
        XCTAssertTrue(AccountSummaryUIModel().generateList().isEmpty)
    }
}

// MARK: - Product summary mapping

final class ProductSummaryUIMapperTests: XCTestCase {

    override func setUp() {
        super.setUp()
        let configuration = AccountsJourney.Configuration()
        Resolver.register { configuration }
    }

    func test_mapping_buildsEveryKindWithItsHeaderAndProducts() throws {
        let summary = try ProductSummary.fixture().toMapUI()
        let strings = AccountsList.Strings()

        XCTAssertEqual(summary.currentAccounts?.header, strings.currentAccountTitle())
        XCTAssertEqual(summary.currentAccounts?.products.map(\.id), ["current-1"])
        XCTAssertEqual(summary.savingAccounts?.header, strings.savingsAccountTitle())
        XCTAssertEqual(summary.loans?.header, strings.loanAccountTitle())
        XCTAssertEqual(summary.customProducts?.count, 1)
        XCTAssertEqual(summary.customProducts?.first?.header, strings.generalAccountTitle())
        XCTAssertNil(summary.termDeposits)
        XCTAssertNil(summary.creditCards)
        XCTAssertNil(summary.debitCards)
        XCTAssertNil(summary.investmentAccounts)
    }

    func test_mapping_keepsEveryAccountField() throws {
        let account = try XCTUnwrap(ProductSummary.fixture().toMapUI().currentAccounts?.products.first)

        XCTAssertEqual(account.id, "current-1")
        XCTAssertEqual(account.name, "Main account")
        XCTAssertEqual(account.balance, Currency(amount: "1250.50", currencyCode: "EUR"))
        XCTAssertEqual(account.isVisible, true)
    }

    func test_mapping_showsTheNumber_forActiveAccounts_andTheStateOtherwise() throws {
        let summary = try ProductSummary.fixture().toMapUI()

        XCTAssertEqual(summary.currentAccounts?.products.first?.state, "BBAN-1")
        XCTAssertEqual(summary.loans?.products.first?.state, "Closed")
    }

    func test_mapping_dropsEmptyKinds() throws {
        let summary = try ProductSummary.decode(#"{"currentAccounts": {"products": []}, "customProductKinds": [{"products": []}]}"#)
            .toMapUI()

        XCTAssertNil(summary.currentAccounts)
        XCTAssertEqual(summary.customProducts?.first?.products.isEmpty, true)
        XCTAssertTrue(summary.generateList().isEmpty)
    }

    func test_generateList_keepsTheKindOrder_ofTheMappedSummary() throws {
        let summary = try ProductSummary.fixture().toMapUI()

        XCTAssertEqual(summary.generateList().map(\.id), ["current-1", "savings-1", "loan-1", "custom-1"])
    }

    func test_mapping_usesTheIconOfTheDesign() throws {
        var configuration = AccountsJourney.Configuration()
        configuration.design.accountIcon = { _ in
            AccountIconInfo(icon: UIImage(), backgroundColor: .green)
        }
        Resolver.register { configuration }

        let account = try XCTUnwrap(ProductSummary.fixture().toMapUI().currentAccounts?.products.first)

        XCTAssertEqual(account.iconName?.backgroundColor, UIColor.green)
    }
}

extension ProductSummary {

    static func decode(_ json: String) throws -> ProductSummary {
        try JSONDecoder().decode(ProductSummary.self, from: Data(json.utf8))
    }

    /// One current account, one savings account, one closed loan and one custom product.
    static func fixture() throws -> ProductSummary {
        try decode("""
        {
          "currentAccounts": {"products": [
            {"id": "current-1", "name": "Main account", "bookedBalance": "1250.50", "currency": "EUR",
             "BBAN": "BBAN-1", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]},
          "savingsAccounts": {"products": [
            {"id": "savings-1", "name": "Holiday savings", "bookedBalance": "9800", "currency": "EUR",
             "IBAN": "IBAN-2", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]},
          "loans": {"products": [
            {"id": "loan-1", "name": "Car loan", "bookedBalance": "-12000", "currency": "EUR",
             "BBAN": "BBAN-3", "visible": false, "state": {"state": "Closed"}, "debitCardsItems": []}
          ]},
          "customProductKinds": [{"name": "Other", "products": [
            {"id": "custom-1", "name": "Gold bars", "bookedBalance": "5", "currency": "USD",
             "productKindName": "Precious", "visible": true, "state": {"state": "Active"}, "debitCardsItems": []}
          ]}]
        }
        """)
    }
}

// MARK: - Screen state

final class AccountListScreenStateTests: XCTestCase {

    private let configuration = GenericStateViewConfiguration(title: "", subtitle: "")

    func test_isLoading_isOnlyTrueWhileLoading() {
        XCTAssertTrue(AccountListScreenState.loading.isLoading)
        XCTAssertFalse(AccountListScreenState.loaded.isLoading)
        XCTAssertFalse(AccountListScreenState.emptyResults(configuration).isLoading)
        XCTAssertFalse(AccountListScreenState.hasError(configuration).isLoading)
    }

    func test_isError_isOnlyTrueForErrors() {
        XCTAssertTrue(AccountListScreenState.hasError(configuration).isError)
        XCTAssertFalse(AccountListScreenState.loading.isError)
        XCTAssertFalse(AccountListScreenState.loaded.isError)
        XCTAssertFalse(AccountListScreenState.emptyResults(configuration).isError)
    }
}

// MARK: - View model

@MainActor
final class AccountsListViewModelSwiftUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        let configuration = AccountsJourney.Configuration()
        Resolver.register { configuration }
    }

    func test_refreshAccounts_returnsOnlyOnceTheReloadHasFinished() async {
        let useCase = DelayedFailingUseCase()
        Resolver.register { useCase as AccountsListUseCase }
        let viewModel = AccountsListViewModel()

        await viewModel.refreshAccounts()

        XCTAssertEqual(useCase.callCount, 1)
        XCTAssertFalse(viewModel.screenState.isLoading)
        XCTAssertTrue(viewModel.screenState.isError)
    }

    func test_failedLoad_clearsTheAccounts() async throws {
        let useCase = StubAccountsListUseCase(result: .success(try ProductSummary.fixture()))
        Resolver.register { useCase as AccountsListUseCase }
        let viewModel = AccountsListViewModel()
        viewModel.onEvent(.getAccounts)
        XCTAssertFalse(viewModel.allAccounts.isEmpty)

        useCase.result = .failure(.error(500, nil, AccountsList.Error.invalidResponse))
        viewModel.onEvent(.refresh)

        XCTAssertTrue(viewModel.allAccounts.isEmpty)
    }

    func test_loadedAccounts_areExposedAsUIModels() throws {
        let useCase = StubAccountsListUseCase(result: .success(try ProductSummary.fixture()))
        Resolver.register { useCase as AccountsListUseCase }
        let viewModel = AccountsListViewModel()

        viewModel.onEvent(.getAccounts)

        XCTAssertEqual(viewModel.allAccounts.map(\.id), ["current-1", "savings-1", "loan-1", "custom-1"])
        XCTAssertFalse(viewModel.screenState.isLoading)
        XCTAssertFalse(viewModel.screenState.isError)
    }

    func test_search_filtersTheAccounts() throws {
        let useCase = StubAccountsListUseCase(result: .success(try ProductSummary.fixture()))
        Resolver.register { useCase as AccountsListUseCase }
        let viewModel = AccountsListViewModel()

        viewModel.onEvent(.search("loan"))

        XCTAssertEqual(viewModel.allAccounts.map(\.id), ["loan-1"])
    }

    func test_search_withoutMatches_showsTheEmptyState_andNoAccounts() throws {
        let useCase = StubAccountsListUseCase(result: .success(try ProductSummary.fixture()))
        Resolver.register { useCase as AccountsListUseCase }
        let viewModel = AccountsListViewModel()

        viewModel.onEvent(.search("xyz"))

        XCTAssertTrue(viewModel.allAccounts.isEmpty)
        guard case .emptyResults = viewModel.screenState else {
            return XCTFail("Expected the empty results state, got \(viewModel.screenState)")
        }
    }
}

private final class StubAccountsListUseCase: AccountsListUseCase {

    var result: Result<ProductSummary, ErrorResponse>

    init(result: Result<ProductSummary, ErrorResponse>) {
        self.result = result
    }

    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ErrorResponse>) -> Void) {
        completion(result)
    }
}

private final class DelayedFailingUseCase: AccountsListUseCase {

    private(set) var callCount = 0

    func getAccountSummary(_ completion: @escaping (Result<ProductSummary, ErrorResponse>) -> Void) {
        callCount += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion(.failure(.error(500, nil, AccountsList.Error.invalidResponse)))
        }
    }
}
