import XCTest
import SnapshotTesting
import Resolver
@testable import GoldenAccountsUseCase
@testable import AccountsJourney
import AccessControlClient3Gen2
import ArrangementsClient2Gen2
import Backbase
//@testable import GoldenSampleApp

class AccountDetailsScreenSnapshotTests: XCTestCase {
    // MARK: Properties
    lazy var productSummaryClient = clientFactory(ArrangementsClient2Gen2.ProductSummaryAPI(), "api/arrangement-manager")
    lazy var arrangementsClient = clientFactory(ArrangementsClient2Gen2.ArrangementsAPI(), "api/arrangement-manager")

    func clientFactory<T: DBSClient>(_ client: T, _ path: String) -> T {
        guard let serverURL: URL = URL(string: Backbase.configuration().backbase.serverURL) else {
            fatalError("Invalid or no serverURL found in the SDK configuration")
        }
        client.baseURL = serverURL.appendingPathComponent(path)
        
        if let dataProvider = Resolver.optional(DBSDataProvider.self) {
            client.dataProvider = dataProvider
            return client
        } else {
            try? Backbase.register(client: client)
            guard let dbsClient = Backbase.registered(client: T.self),
                  let client = dbsClient as? T else {
                fatalError("Failed to retrieve \(T.self) client")
            }
            return client
        }
    }

    func testSuggestionsHappyPath() {
        Resolver.register { AccountsListSummaryUseCaseImp(client: self.productSummaryClient) as AccountsListUseCase }
        Resolver.register { AccountDetailUseCaseImp(client: self.arrangementsClient) as AccountDetailsUseCase}
        Resolver.register { AccountsJourney.Configuration() }
        let viewModel = AccountDetailsViewModel()
        let viewController = AccountDetailsViewController(viewModel: viewModel, arrangementId: "")
        
        let result = verifyViewSnapshot(with: viewController.view)
                XCTAssertTrue(result.isEmpty, "Failed in \(#function) snapshot test")
        
    }
}
