import ArrangementsClient2Gen2
import ClientCommonGen2
import Testing
@testable import AccountsJourney

// MARK: - Model

@Suite("AccountDetailsModel", .timeLimit(.minutes(1)))
@MainActor
struct AccountDetailsModelTests {

    @Test
    func fetchAccountDetail_requestsTheAccountOfTheModel() async throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        let model = AccountDetailsModel(arrangementId: "other-arrangement", useCase: useCase)

        _ = await model.fetchAccountDetail()

        #expect(useCase.requestedIds == ["other-arrangement"])
    }

    @Test
    func fetchAccountDetail_returnsTheAccountOfTheUseCase() async throws {
        let useCase = StubAccountDetailsUseCase(result: .success(try .fixture()))
        let model = AccountDetailsModel(arrangementId: "arrangement-1", useCase: useCase)

        let result = await model.fetchAccountDetail()

        #expect(try result.get().id == "arrangement-1")
    }

    @Test
    func fetchAccountDetail_returnsTheFailureOfTheUseCase() async {
        let failure = Result<AccountArrangementItem, ErrorResponse>.failure(.error(500, nil, AccountDetails.Error.invalidResponse))
        let model = AccountDetailsModel(arrangementId: "arrangement-1", useCase: StubAccountDetailsUseCase(result: failure))

        let result = await model.fetchAccountDetail()

        guard case .failure = result else {
            Issue.record("Expected a failure, got \(result)")
            return
        }
    }

    @Test
    func fetchAccountDetail_returnsOnlyOnceTheUseCaseHasAnswered() async throws {
        let useCase = DeferredAccountDetailsUseCase()
        let model = AccountDetailsModel(arrangementId: "arrangement-1", useCase: useCase)

        let fetch = Task { await model.fetchAccountDetail() }
        while useCase.requestCount == 0 { await Task.yield() }
        useCase.complete(request: 0, with: .success(try .fixture()))
        let result = await fetch.value

        #expect(try result.get().id == "arrangement-1")
    }
}
