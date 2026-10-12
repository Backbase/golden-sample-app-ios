import BackbaseDesignSystem
import Testing
import UIKit
@testable import AccountsJourney

// MARK: - Row content

@Suite("AccountDetailsRowContent")
struct AccountDetailsRowContentTests {

    private let strings = AccountDetails.Strings()

    @Test
    func detailsRows_showTheHolderNameAndTheAccountNumber() {
        let rows = AccountDetailsRowContent.detailsRows(for: .fixture(), strings: strings)

        #expect(rows == [
            AccountDetailsRowContent(title: strings.holderNamesTitle(), subtitle: "John Doe"),
            AccountDetailsRowContent(title: strings.cardOrAccountNumberTitle(), subtitle: "NL91ABNA0417164300")
        ])
    }

    @Test
    func generalRows_showTheProductKindNameAsTypeAndName() {
        let rows = AccountDetailsRowContent.generalRows(for: .fixture(productKindName: "Savings"), strings: strings)

        #expect(rows == [
            AccountDetailsRowContent(title: strings.accountTypeTitle(), subtitle: "Savings"),
            AccountDetailsRowContent(title: strings.accountNameTitle(), subtitle: "Savings")
        ])
    }

    @Test("The status row shows the account state, or nothing without one", arguments: [
        ("Closed" as String?, "Closed"),
        ("Active", "Active"),
        (nil, "")
    ])
    func statusRows_showTheAccountState(state: String?, expected: String) {
        let rows = AccountDetailsRowContent.statusRows(for: .fixture(accountState: state), strings: strings)

        #expect(rows == [AccountDetailsRowContent(title: strings.accountStatusTitle(), subtitle: expected)])
    }
}

// MARK: - Section content

@Suite("AccountDetailsSectionContent")
struct AccountDetailsSectionContentTests {

    private let strings = AccountDetails.Strings()

    @Test
    func title_isUpperCased() {
        let content = AccountDetailsSectionContent(title: "General", rows: [])

        #expect(content.title == "GENERAL")
    }

    @Test
    func title_isNilWhenNotGiven() {
        #expect(AccountDetailsSectionContent(rows: []).title == nil)
    }

    @Test
    func detailsSection_hasAnEmptyTitle_ratherThanNone() {
        let content = AccountDetailsSectionContent.details(for: .fixture(), strings: strings)

        #expect(content.title == "")
        #expect(content.rows == AccountDetailsRowContent.detailsRows(for: .fixture(), strings: strings))
    }

    @Test
    func generalSection_usesTheLocalisedTitle() {
        let content = AccountDetailsSectionContent.general(for: .fixture(), strings: strings)

        #expect(content.title == strings.generalSectionTitle().uppercased())
        #expect(content.rows.count == 2)
    }

    @Test
    func statusSection_usesTheLocalisedTitle() {
        let content = AccountDetailsSectionContent.status(for: .fixture(), strings: strings)

        #expect(content.title == strings.statusSectionTitle().uppercased())
        #expect(content.rows.count == 1)
    }
}

// MARK: - Header content

@Suite("AccountDetailsHeaderContent")
struct AccountDetailsHeaderContentTests {

    private let strings = AccountDetails.Strings()

    @Test
    func init_mapsTheDetailsWithTheGivenFormatter() {
        let icon = AccountIconInfo(icon: UIImage(), backgroundColor: .green)
        let details = AccountDetailsUIModel.fixture(iconName: icon)

        let content = AccountDetailsHeaderContent(
            details: details,
            strings: strings,
            formatAmount: { amount, currency in "\(amount) \(currency)!" }
        )

        #expect(content.icon == icon)
        #expect(content.title == "Current Account")
        #expect(content.subtitle == "NL91ABNA0417164300")
        #expect(content.balance == "3207.61 EUR!")
        #expect(content.limit == "\(strings.limitTitle()) 1055.5 EUR!")
    }

    @Test
    func init_hasNoIcon_whenTheDetailsHaveNone() {
        let content = AccountDetailsHeaderContent(details: .fixture(), strings: strings)

        #expect(content.icon == nil)
    }

    @Test("Amounts are formatted, with or without a currency", arguments: [
        (1250.5, "EUR", ["1", "250"]),
        (10, "", ["10"])
    ])
    func formatAmount_containsTheAmount(amount: Double, currencyCode: String, fragments: [String]) {
        let formatted = AccountDetailsHeaderContent.formatAmount(amount, currencyCode: currencyCode)

        #expect(!formatted.isEmpty)
        for fragment in fragments {
            #expect(formatted.contains(fragment), "Unexpected text: \(formatted)")
        }
    }
}
