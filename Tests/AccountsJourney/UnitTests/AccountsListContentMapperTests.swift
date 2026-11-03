import Testing
import UIKit
@testable import AccountsJourney

@Suite("AccountsListContentMapper")
struct AccountsListContentMapperTests {

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

    private func makeMapper() -> AccountsListContentMapper {
        AccountsListContentMapper(strings: strings, formatAmount: { "\($0.amount) \($0.currencyCode)!" })
    }

    // MARK: Row

    @Test
    func row_defaultsToEmptyName_andNoStateBalanceOrIcon() {
        let row = makeMapper().row(for: AccountData())

        #expect(row == AccountsListRowContent(id: nil, icon: nil, name: "", state: nil, balance: nil))
    }

    @Test
    func row_mapsTheAccount_withTheGivenFormatter() {
        let icon = AccountIconInfo(icon: UIImage(), backgroundColor: .green)
        let account = AccountData(
            id: "savings-1",
            name: "Savings",
            balance: Currency(amount: "10", currencyCode: "EUR"),
            state: "Active",
            iconName: icon
        )

        let row = makeMapper().row(for: account)

        #expect(row == AccountsListRowContent(id: "savings-1", icon: icon, name: "Savings", state: "Active", balance: "10 EUR!"))
    }

    @Test
    func rows_keepTheOrderOfTheAccounts() {
        let rows = makeMapper().rows(for: [AccountData(id: "b"), AccountData(id: "a")])

        #expect(rows.map(\.id) == ["b", "a"])
    }

    // MARK: State

    @Test("Closed and inactive states use a localised caption, whatever their case", arguments: [
        ("Closed", Caption.closed),
        ("closed", .closed),
        ("INACTIVE", .inactive),
        ("Inactive", .inactive)
    ])
    private func stateText_usesLocalisedCaption(state: String, caption: Caption) {
        #expect(makeMapper().stateText(for: state) == caption.text(strings))
    }

    @Test("Any other state is kept", arguments: ["Active", "Pending"])
    func stateText_isKept(state: String) {
        #expect(makeMapper().stateText(for: state) == state)
    }

    @Test
    func stateText_isNil_withoutAState() {
        #expect(makeMapper().stateText(for: nil) == nil)
    }

    // MARK: Formatting

    @Test
    func designSystemAmount_containsTheAmount() {
        let formatted = AccountsListContentMapper.designSystemAmount(Currency(amount: "1250.5", currencyCode: "EUR"))

        #expect(!formatted.isEmpty)
        #expect(formatted.contains("1"), "Unexpected text: \(formatted)")
    }
}
