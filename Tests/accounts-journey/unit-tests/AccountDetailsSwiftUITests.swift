import ArrangementsClient2Gen2
import BackbaseDesignSystem
import ClientCommonGen2
import Combine
import Resolver
import SwiftUI
import UIKit
import XCTest
@testable import AccountsJourney

// MARK: - Fixtures

extension AccountDetailsUIModel {

    static func fixture(
        displayName: String = "John Doe",
        BBAN: String = "NL91ABNA0417164300",
        currency: String = "EUR",
        availableBalance: Double = 3207.61,
        creditLimit: Double = 1055.5,
        productKindName: String = "Current Account",
        accountState: String? = "Active",
        iconName: AccountIconInfo? = nil
    ) -> AccountDetailsUIModel {
        AccountDetailsUIModel(
            id: "1",
            name: "Main account",
            displayName: displayName,
            BBAN: BBAN,
            currency: currency,
            availableBalance: availableBalance,
            accountHolderNames: "John Doe",
            productKindName: productKindName,
            productTypeName: "Current Account",
            bankBranchCode: nil,
            lastUpdateDate: "",
            accountInterestRate: nil,
            accruedInterest: 0,
            creditLimit: creditLimit,
            accountOpeningDate: "",
            accountState: accountState,
            iconName: iconName
        )
    }
}

extension AccountArrangementItem {

    static func fixture() throws -> AccountArrangementItem {
        try JSONDecoder().decode(AccountArrangementItem.self, from: Data("""
        {"id": "arrangement-1", "productId": "product-1", "currency": "EUR", "displayName": "John Doe",
         "BBAN": "NL91ABNA0417164300", "productKindName": "Current Account", "availableBalance": 3207.61,
         "creditLimit": 1055.5, "state": {"state": "Active"}}
        """.utf8))
    }
}

// MARK: - Row content

final class AccountDetailsRowContentTests: XCTestCase {

    private let strings = AccountDetails.Strings()

    func test_detailsRows_showTheHolderNameAndTheAccountNumber() {
        let rows = AccountDetailsRowContent.detailsRows(for: .fixture(), strings: strings)

        XCTAssertEqual(rows, [
            AccountDetailsRowContent(title: strings.holderNamesTitle(), subtitle: "John Doe"),
            AccountDetailsRowContent(title: strings.cardOrAccountNumberTitle(), subtitle: "NL91ABNA0417164300")
        ])
    }

    func test_generalRows_showTheProductKindNameAsTypeAndName() {
        let rows = AccountDetailsRowContent.generalRows(for: .fixture(productKindName: "Savings"), strings: strings)

        XCTAssertEqual(rows, [
            AccountDetailsRowContent(title: strings.accountTypeTitle(), subtitle: "Savings"),
            AccountDetailsRowContent(title: strings.accountNameTitle(), subtitle: "Savings")
        ])
    }

    func test_statusRows_showTheAccountState() {
        let rows = AccountDetailsRowContent.statusRows(for: .fixture(accountState: "Closed"), strings: strings)

        XCTAssertEqual(rows, [AccountDetailsRowContent(title: strings.accountStatusTitle(), subtitle: "Closed")])
    }

    func test_statusRows_areEmptyText_whenThereIsNoState() {
        let rows = AccountDetailsRowContent.statusRows(for: .fixture(accountState: nil), strings: strings)

        XCTAssertEqual(rows.first?.subtitle, "")
    }
}

// MARK: - Section content

final class AccountDetailsSectionContentTests: XCTestCase {

    private let strings = AccountDetails.Strings()

    func test_title_isUpperCased() {
        let content = AccountDetailsSectionContent(title: "General", rows: [])

        XCTAssertEqual(content.title, "GENERAL")
    }

    func test_title_isNilWhenNotGiven() {
        XCTAssertNil(AccountDetailsSectionContent(rows: []).title)
    }

    func test_detailsSection_hasAnEmptyTitle_ratherThanNone() {
        let content = AccountDetailsSectionContent.details(for: .fixture(), strings: strings)

        XCTAssertEqual(content.title, "")
        XCTAssertEqual(content.rows, AccountDetailsRowContent.detailsRows(for: .fixture(), strings: strings))
    }

    func test_generalSection_usesTheLocalisedTitle() {
        let content = AccountDetailsSectionContent.general(for: .fixture(), strings: strings)

        XCTAssertEqual(content.title, strings.generalSectionTitle().uppercased())
        XCTAssertEqual(content.rows.count, 2)
    }

    func test_statusSection_usesTheLocalisedTitle() {
        let content = AccountDetailsSectionContent.status(for: .fixture(), strings: strings)

        XCTAssertEqual(content.title, strings.statusSectionTitle().uppercased())
        XCTAssertEqual(content.rows.count, 1)
    }
}

// MARK: - Header content

final class AccountDetailsHeaderContentTests: XCTestCase {

    private let strings = AccountDetails.Strings()

    func test_init_mapsTheDetailsWithTheGivenFormatter() {
        let icon = AccountIconInfo(icon: UIImage(), backgroundColor: .green)
        let details = AccountDetailsUIModel.fixture(iconName: icon)

        let content = AccountDetailsHeaderContent(
            details: details,
            strings: strings,
            formatAmount: { amount, currency in "\(amount) \(currency)!" }
        )

        XCTAssertEqual(content.icon, icon)
        XCTAssertEqual(content.title, "Current Account")
        XCTAssertEqual(content.subtitle, "NL91ABNA0417164300")
        XCTAssertEqual(content.balance, "3207.61 EUR!")
        XCTAssertEqual(content.limit, "\(strings.limitTitle()) 1055.5 EUR!")
    }

    func test_init_hasNoIcon_whenTheDetailsHaveNone() {
        let content = AccountDetailsHeaderContent(details: .fixture(), strings: strings)

        XCTAssertNil(content.icon)
    }

    func test_formatAmount_containsTheAmount_inTheGivenCurrency() {
        let formatted = AccountDetailsHeaderContent.formatAmount(1250.5, currencyCode: "EUR")

        XCTAssertTrue(formatted.contains("1"), "Unexpected text: \(formatted)")
        XCTAssertTrue(formatted.contains("250"), "Unexpected text: \(formatted)")
    }

    func test_formatAmount_stillFormats_whenTheCurrencyIsEmpty() {
        let formatted = AccountDetailsHeaderContent.formatAmount(10, currencyCode: "")

        XCTAssertFalse(formatted.isEmpty)
        XCTAssertTrue(formatted.contains("10"), "Unexpected text: \(formatted)")
    }
}

// MARK: - Emblem appearance

final class EmblemAppearanceBackgroundTests: XCTestCase {

    func test_nilColor_isNeutral() {
        XCTAssertEqual(EmblemAppearance.appearance(forBackground: nil), .neutral)
    }

    func test_designSystemTokens_mapToTheirAppearance() {
        XCTAssertEqual(EmblemAppearance.appearance(forBackground: Theme.colors.background.brandSubtle), .brand)
        XCTAssertEqual(EmblemAppearance.appearance(forBackground: Theme.colors.background.dangerSubtle), .danger)
        XCTAssertEqual(EmblemAppearance.appearance(forBackground: Theme.colors.background.category3Subtle), .category3)
    }

    func test_unknownColor_isNeutral() {
        XCTAssertEqual(EmblemAppearance.appearance(forBackground: UIColor(red: 0.123, green: 0.456, blue: 0.789, alpha: 1)), .neutral)
    }

    func test_matchesTheColorOverload() {
        let uiColor = Theme.colors.background.successSubtle

        XCTAssertEqual(
            EmblemAppearance.appearance(forBackground: uiColor),
            EmblemAppearance.appearance(for: Color(uiColor: uiColor))
        )
    }
}

// MARK: - Shadow

final class ShadowParametersTests: XCTestCase {

    func test_designSystemShadow_isMappedToTheShadowParameters() {
        let shadow = DesignSystem.shared.shadows.small

        let parameters = ShadowStyleModifier.ShadowParameters.designSystem(shadow)

        XCTAssertEqual(parameters.radius, shadow.radius)
        XCTAssertEqual(parameters.x, shadow.offset.width)
        XCTAssertEqual(parameters.y, shadow.offset.height)
    }

    func test_cardView_usesTheSmallShadowOfTheDesignSystem() {
        let small = DesignSystem.shared.shadows.small

        let parameters = ShadowStyleModifier.ShadowParameters.cardView

        XCTAssertEqual(parameters.radius, small.radius)
        XCTAssertEqual(parameters.y, small.offset.height)
    }
}

// MARK: - View model

@MainActor
final class AccountDetailsViewModelSwiftUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        let configuration = AccountsJourney.Configuration()
        Resolver.register { configuration }
    }

    func test_viewModel_isAnObservableObject_thatPublishesEveryStateChange() throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        Resolver.register { useCase as AccountDetailsUseCase }
        let viewModel = AccountDetailsViewModel()
        var changes = 0
        let cancellable = viewModel.objectWillChange.sink { changes += 1 }

        viewModel.onEvent(.getAccountDetails("arrangement-1"))

        // `loading`, then `loaded`.
        XCTAssertEqual(changes, 2)
        cancellable.cancel()
    }

    func test_getAccountDetails_loadsTheMappedDetails() throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        Resolver.register { useCase as AccountDetailsUseCase }
        let viewModel = AccountDetailsViewModel()

        viewModel.onEvent(.getAccountDetails("arrangement-1"))

        XCTAssertEqual(useCase.requestedIds, ["arrangement-1"])
        guard case let .loaded(details) = viewModel.screenState else {
            return XCTFail("Expected the loaded state, got \(viewModel.screenState)")
        }
        XCTAssertEqual(details.id, "arrangement-1")
        XCTAssertEqual(details.displayName, "John Doe")
        XCTAssertEqual(details.BBAN, "NL91ABNA0417164300")
        XCTAssertEqual(details.availableBalance, 3207.61)
        XCTAssertEqual(details.creditLimit, 1055.5)
        XCTAssertEqual(details.accountState, "Active")
    }

    func test_getAccountDetails_showsTheError_whenTheCallFails() {
        let useCase = StubAccountDetailsUseCase(result: .failure(.error(500, nil, AccountDetails.Error.invalidResponse)))
        Resolver.register { useCase as AccountDetailsUseCase }
        let viewModel = AccountDetailsViewModel()

        viewModel.onEvent(.getAccountDetails("arrangement-1"))

        guard case .hasError = viewModel.screenState else {
            return XCTFail("Expected the error state, got \(viewModel.screenState)")
        }
    }

    func test_errorRetryAction_requestsTheSameAccountAgain() throws {
        let useCase = StubAccountDetailsUseCase(result: .failure(.error(500, nil, AccountDetails.Error.invalidResponse)))
        Resolver.register { useCase as AccountDetailsUseCase }
        let viewModel = AccountDetailsViewModel()
        viewModel.onEvent(.getAccountDetails("arrangement-1"))
        guard case let .hasError(stateConfiguration) = viewModel.screenState else {
            return XCTFail("Expected the error state, got \(viewModel.screenState)")
        }

        useCase.result = .success(try .fixture())
        let retry = try XCTUnwrap(stateConfiguration.firstButtonConfiguration)
        retry.action()

        XCTAssertEqual(useCase.requestedIds, ["arrangement-1", "arrangement-1"])
        guard case .loaded = viewModel.screenState else {
            return XCTFail("Expected the loaded state, got \(viewModel.screenState)")
        }
    }
}

private final class StubAccountDetailsUseCase: AccountDetailsUseCase {

    var result: Result<AccountArrangementItem, ClientCommonGen2.ErrorResponse>
    private(set) var requestedIds = [String]()

    init(result: Result<AccountArrangementItem, ClientCommonGen2.ErrorResponse>) {
        self.result = result
    }

    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountArrangementItem, ClientCommonGen2.ErrorResponse>) -> Void
    ) {
        requestedIds.append(arrangementId)
        completion(result)
    }
}

// MARK: - Entry point and navigation

@MainActor
final class AccountDetailsBuildSwiftUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        let configuration = AccountsJourney.Configuration()
        Resolver.register { configuration }
    }

    func test_buildSwiftUI_returnsAHostingControllerForTheSwiftUIScreen() {
        let viewController = AccountDetails.buildSwiftUI(navigationController: UINavigationController(), arrangementId: "1")

        XCTAssertTrue(viewController is UIHostingController<AccountDetailsView>)
    }

    func test_selectingAnAccount_withTheDefaultRouter_pushesTheSwiftUIAccountDetails() {
        let navigationController = UINavigationController()
        let configuration = AccountsJourney.Configuration()

        configuration.accountsList.router.didSelectProduct(navigationController)("arrangement-1")

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.topViewController is UIHostingController<AccountDetailsView>)
    }
}
