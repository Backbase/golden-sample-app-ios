import XCTest
import SwiftUI
import UIKit
import BackbaseDesignSystem
@testable import AccountsJourney

final class AccountsListRowContentTests: XCTestCase {

    private let strings = AccountsList.Strings()

    func test_name_defaultsToEmptyString() {
        let content = AccountsListRowContent(account: AccountUIModel(), strings: strings)

        XCTAssertEqual(content.name, "")
        XCTAssertNil(content.state)
        XCTAssertNil(content.balance)
    }

    func test_state_usesLocalisedCaption_forClosedAndInactiveAccounts() {
        XCTAssertEqual(AccountsListRowContent.stateText(for: "Closed", strings: strings), strings.closedAccountSubtitle())
        XCTAssertEqual(AccountsListRowContent.stateText(for: "INACTIVE", strings: strings), strings.inactiveAccountSubtitle())
    }

    func test_state_isKept_forAnyOtherState() {
        XCTAssertEqual(AccountsListRowContent.stateText(for: "Active", strings: strings), "Active")
        XCTAssertNil(AccountsListRowContent.stateText(for: nil, strings: strings))
    }

    func test_balance_isFormattedWithTheGivenFormatter() {
        let account = AccountUIModel(
            name: "Savings",
            balance: Currency(amount: "10", currencyCode: "EUR")
        )

        let content = AccountsListRowContent(account: account, strings: strings, formatAmount: { "\($0.amount) \($0.currencyCode)!" })

        XCTAssertEqual(content.name, "Savings")
        XCTAssertEqual(content.balance, "10 EUR!")
    }

    func test_state_isTakenFromTheAccount() {
        let closed = AccountsListRowContent(account: AccountUIModel(state: "Closed"), strings: strings)
        let active = AccountsListRowContent(account: AccountUIModel(state: "Active"), strings: strings)

        XCTAssertEqual(closed.state, strings.closedAccountSubtitle())
        XCTAssertEqual(active.state, "Active")
    }

    func test_formatAmount_withDesignSystemFormatter_containsTheAmount() {
        let formatted = AccountsListRowContent.formatAmount(Currency(amount: "1250.5", currencyCode: "EUR"))

        XCTAssertFalse(formatted.isEmpty)
        XCTAssertTrue(formatted.contains("1"), "Unexpected text: \(formatted)")
    }
}

final class EmblemAppearanceTests: XCTestCase {

    func test_nilColor_isNeutral() {
        XCTAssertEqual(EmblemAppearance.appearance(for: nil), .neutral)
    }

    func test_unknownColor_isNeutral() {
        XCTAssertEqual(EmblemAppearance.appearance(for: Color(red: 0.123, green: 0.456, blue: 0.789)), .neutral)
    }

    func test_knownTokens_mapToTheirAppearance() {
        XCTAssertEqual(EmblemAppearance.appearance(for: Color(Theme.colors.background.brandSubtle)), .brand)
        XCTAssertEqual(EmblemAppearance.appearance(for: Color(Theme.colors.background.successSubtle)), .success)
        XCTAssertEqual(EmblemAppearance.appearance(for: Color(Theme.colors.background.category2Subtle)), .category2)
        XCTAssertEqual(EmblemAppearance.appearance(for: Color(Theme.colors.background.category5Subtle)), .category5)
    }

    /// `AccountIconInfo` carries a `UIColor`; the row converts it with `Color(uiColor:)`.
    func test_uiColorOfAnAccountIcon_isMatchedAfterTheConversionTheRowDoes() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: Theme.colors.background.successSubtle)

        XCTAssertEqual(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))), .success)
    }

    func test_iconWithoutBackgroundColor_isNeutral() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: nil)

        XCTAssertEqual(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))), .neutral)
    }

    func test_colorWithDarkModeOverride_isMatchedByItsLightValue() {
        let color = Color(UIColor(light: Theme.colors.background.brandSubtle, dark: Theme.colors.background.surface2))

        XCTAssertEqual(EmblemAppearance.appearance(for: color), .brand)
    }
}
