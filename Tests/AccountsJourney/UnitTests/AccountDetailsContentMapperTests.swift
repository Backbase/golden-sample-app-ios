import Testing
import UIKit
@testable import AccountsJourney

@Suite("AccountDetailsContentMapper")
struct AccountDetailsContentMapperTests {

    private let strings = AccountDetails.Strings()

    private func makeMapper() -> AccountDetailsContentMapper {
        AccountDetailsContentMapper(strings: strings, formatAmount: { amount, currency in "\(amount) \(currency)!" })
    }

    // MARK: Header

    @Test
    func header_mapsTheDetailsWithTheGivenFormatter() {
        let icon = AccountIconInfo(icon: UIImage(), backgroundColor: .green)

        let header = makeMapper().header(for: .fixture(iconName: icon))

        #expect(header.icon == icon)
        #expect(header.title == "Current Account")
        #expect(header.subtitle == "NL91ABNA0417164300")
        #expect(header.balance == "3207.61 EUR!")
        #expect(header.limit == "\(strings.limitTitle()) 1055.5 EUR!")
    }

    @Test
    func header_hasNoIcon_whenTheDetailsHaveNone() {
        #expect(makeMapper().header(for: .fixture()).icon == nil)
    }

    // MARK: Sections

    @Test
    func sections_areTheDetailsGeneralAndStatusOnes_inOrder() {
        let sections = makeMapper().sections(for: .fixture())

        #expect(sections.map(\.title) == [
            "",
            strings.generalSectionTitle().uppercased(),
            strings.statusSectionTitle().uppercased()
        ])
    }

    @Test
    func detailsSection_showsTheHolderNameAndTheAccountNumber_underAnEmptyTitle() {
        let section = makeMapper().sections(for: .fixture())[0]

        #expect(section.title == "")
        #expect(section.rows == [
            AccountDetailsRowContent(title: strings.holderNamesTitle(), subtitle: "John Doe"),
            AccountDetailsRowContent(title: strings.cardOrAccountNumberTitle(), subtitle: "NL91ABNA0417164300")
        ])
    }

    @Test
    func generalSection_showsTheProductKindAsType_andTheArrangementNameAsName() {
        let section = makeMapper().sections(for: .fixture(productKindName: "Savings"))[1]

        #expect(section.rows == [
            AccountDetailsRowContent(title: strings.accountTypeTitle(), subtitle: "Savings"),
            AccountDetailsRowContent(title: strings.accountNameTitle(), subtitle: "Main account")
        ])
    }

    @Test("The status row shows the account state, or nothing without one", arguments: [
        ("Closed" as String?, "Closed"),
        ("Active", "Active"),
        (nil, "")
    ])
    func statusSection_showsTheAccountState(state: String?, expected: String) {
        let section = makeMapper().sections(for: .fixture(accountState: state))[2]

        #expect(section.rows == [AccountDetailsRowContent(title: strings.accountStatusTitle(), subtitle: expected)])
    }

    // MARK: Content

    @Test
    func content_combinesTheHeaderAndTheSections() {
        let mapper = makeMapper()
        let details = AccountDetailsData.fixture()

        let content = mapper.content(for: details)

        #expect(content.header == mapper.header(for: details))
        #expect(content.sections == mapper.sections(for: details))
    }

    // MARK: Formatting

    @Test("Amounts are formatted by the design system, with or without a currency", arguments: [
        (1250.5, "EUR", ["1", "250"]),
        (10, "", ["10"])
    ])
    func designSystemAmount_containsTheAmount(amount: Double, currencyCode: String, fragments: [String]) {
        let formatted = AccountDetailsContentMapper.designSystemAmount(amount, currencyCode: currencyCode)

        #expect(!formatted.isEmpty)
        for fragment in fragments {
            #expect(formatted.contains(fragment), "Unexpected text: \(formatted)")
        }
    }
}
