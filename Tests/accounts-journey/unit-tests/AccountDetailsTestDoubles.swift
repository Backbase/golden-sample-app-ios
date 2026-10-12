import ArrangementsClient2Gen2
import ClientCommonGen2
import Foundation
@testable import AccountsJourney

// Test doubles and fixtures shared by the account details tests.

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

final class StubAccountDetailsUseCase: AccountDetailsUseCase {

    var result: Result<AccountArrangementItem, ErrorResponse>
    private(set) var requestedIds = [String]()

    init(result: Result<AccountArrangementItem, ErrorResponse>) {
        self.result = result
    }

    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountArrangementItem, ErrorResponse>) -> Void
    ) {
        requestedIds.append(arrangementId)
        completion(result)
    }
}

/// Answers only when told to, so that loads can overlap.
final class DeferredAccountDetailsUseCase: AccountDetailsUseCase {

    private var completions = [(Result<AccountArrangementItem, ErrorResponse>) -> Void]()
    var requestCount: Int { completions.count }

    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountArrangementItem, ErrorResponse>) -> Void
    ) {
        completions.append(completion)
    }

    func complete(request index: Int, with result: Result<AccountArrangementItem, ErrorResponse>) {
        completions[index](result)
    }
}
