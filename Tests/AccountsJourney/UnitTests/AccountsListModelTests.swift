import ArrangementsClient2Gen2
import ClientCommonGen2
import Testing
@testable import AccountsJourney

// MARK: - Model

@Suite("AccountsListModel")
@MainActor
struct AccountsListModelTests {

    private func makeModel(
        result: Result<ProductSummary, ErrorResponse>
    ) -> (model: AccountsListModel, useCase: StubAccountsListUseCase, routing: AccountsListRoutingSpy) {
        let useCase = StubAccountsListUseCase(result: result)
        let routing = AccountsListRoutingSpy()
        return (AccountsListModel(useCase: useCase, routing: routing), useCase, routing)
    }

    @Test
    func fetchAccountSummary_returnsTheSummaryOfTheUseCase() async throws {
        let (model, useCase, _) = makeModel(result: .success(try ProductSummary.fixture()))

        let result = await model.fetchAccountSummary()

        let summary = try result.get()
        #expect(summary.currentAccounts?.products.first?.id == "current-1")
        #expect(useCase.callCount == 1)
    }

    @Test
    func fetchAccountSummary_returnsTheFailureOfTheUseCase() async {
        let failure = Result<ProductSummary, ErrorResponse>.failure(.error(500, nil, AccountsList.Error.invalidResponse))
        let (model, _, _) = makeModel(result: failure)

        let result = await model.fetchAccountSummary()

        guard case .failure = result else {
            Issue.record("Expected a failure, got \(result)")
            return
        }
    }

    @Test
    func navigateToDetails_isDelegatedToTheRouting() throws {
        let (model, _, routing) = makeModel(result: .success(try ProductSummary.fixture()))

        model.navigateToDetails(ofAccountWithID: "loan-1")

        #expect(routing.navigatedAccountIDs == ["loan-1"])
    }
}
