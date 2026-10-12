import BackbaseDesignSystem
import SwiftUI
import Testing
import UIKit
@testable import AccountsJourney

@Suite("AccountsListRowContent")
struct AccountsListRowContentTests {

    private let strings = AccountsList.Strings()

    /// The caption a state is replaced with, resolved against the strings of the test.
    private enum Caption: Sendable {
        case closed, inactive

        func text(_ strings: AccountsList.Strings) -> String {
            switch self {
            case .closed: strings.closedAccountSubtitle()
            case .inactive: strings.inactiveAccountSubtitle()
            }
        }
    }

    @Test
    func name_defaultsToEmptyString() {
        let content = AccountsListRowContent(account: AccountUIModel(), strings: strings)

        #expect(content.name == "")
        #expect(content.state == nil)
        #expect(content.balance == nil)
    }

    @Test("Closed and inactive states use a localised caption, whatever their case", arguments: [
        ("Closed", Caption.closed),
        ("closed", .closed),
        ("INACTIVE", .inactive),
        ("Inactive", .inactive)
    ])
    private func stateText_usesLocalisedCaption(state: String, caption: Caption) {
        #expect(AccountsListRowContent.stateText(for: state, strings: strings) == caption.text(strings))
    }

    @Test("Any other state is kept", arguments: ["Active", "Pending"])
    func stateText_isKept(state: String) {
        #expect(AccountsListRowContent.stateText(for: state, strings: strings) == state)
    }

    @Test
    func stateText_isNil_withoutAState() {
        #expect(AccountsListRowContent.stateText(for: nil, strings: strings) == nil)
    }

    @Test
    func balance_isFormattedWithTheGivenFormatter() {
        let account = AccountUIModel(
            name: "Savings",
            balance: Currency(amount: "10", currencyCode: "EUR")
        )

        let content = AccountsListRowContent(account: account, strings: strings, formatAmount: { "\($0.amount) \($0.currencyCode)!" })

        #expect(content.name == "Savings")
        #expect(content.balance == "10 EUR!")
    }

    @Test
    func state_isTakenFromTheAccount() {
        let closed = AccountsListRowContent(account: AccountUIModel(state: "Closed"), strings: strings)
        let active = AccountsListRowContent(account: AccountUIModel(state: "Active"), strings: strings)

        #expect(closed.state == strings.closedAccountSubtitle())
        #expect(active.state == "Active")
    }

    @Test
    func formatAmount_withDesignSystemFormatter_containsTheAmount() {
        let formatted = AccountsListRowContent.formatAmount(Currency(amount: "1250.5", currencyCode: "EUR"))

        #expect(!formatted.isEmpty)
        #expect(formatted.contains("1"), "Unexpected text: \(formatted)")
    }
}

@Suite("EmblemAppearance")
struct EmblemAppearanceTests {

    @Test
    func nilColor_isNeutral() {
        #expect(EmblemAppearance.appearance(for: nil) == .neutral)
    }

    @Test
    func unknownColor_isNeutral() {
        #expect(EmblemAppearance.appearance(for: Color(red: 0.123, green: 0.456, blue: 0.789)) == .neutral)
    }

    @Test("Design system tokens map to their appearance", arguments: [
        (Color(Theme.colors.background.brandSubtle), BB.Emblem.Appearance.brand),
        (Color(Theme.colors.background.successSubtle), .success),
        (Color(Theme.colors.background.category2Subtle), .category2),
        (Color(Theme.colors.background.category5Subtle), .category5)
    ])
    func knownTokens_mapToTheirAppearance(color: Color, expected: BB.Emblem.Appearance) {
        #expect(EmblemAppearance.appearance(for: color) == expected)
    }

    /// `AccountIconInfo` carries a `UIColor`; the row converts it with `Color(uiColor:)`.
    @Test
    func uiColorOfAnAccountIcon_isMatchedAfterTheConversionTheRowDoes() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: Theme.colors.background.successSubtle)

        #expect(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))) == .success)
    }

    @Test
    func iconWithoutBackgroundColor_isNeutral() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: nil)

        #expect(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))) == .neutral)
    }

    @Test
    func iconInfo_isNotEqual_whenOnlyTheBackgroundColorDiffers() {
        let icon = UIImage()
        let red = AccountIconInfo(icon: icon, backgroundColor: .red)
        let blue = AccountIconInfo(icon: icon, backgroundColor: .blue)

        #expect(red == AccountIconInfo(icon: icon, backgroundColor: .red))
        #expect(red != blue)
    }

    @Test
    func colorWithDarkModeOverride_isMatchedByItsLightValue() {
        let color = Color(UIColor(light: Theme.colors.background.brandSubtle, dark: Theme.colors.background.surface2))

        #expect(EmblemAppearance.appearance(for: color) == .brand)
    }
}
