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
    override func setUp() {
//        isRecording = true
    }

    func testSuggestionsHappyPath() {
        
        Resolver.register { AccountsJourney.Configuration() }
        
        let viewModel = AccountDetailsViewModel()
        // Register the Mock
        Resolver.register { MockAccountDetailsUseCase() as AccountDetailsUseCase }
        
        let viewController = AccountDetailsViewController(viewModel: viewModel, arrangementId: "")
        
        // fire the event that fetches account details
        viewController.viewModel.onEvent(.getAccountDetails(""))
        
        let result = verifyViewSnapshot(with: viewController.view)
                XCTAssertTrue(result.isEmpty, "Failed in \(#function) snapshot test")
        
    }
    
    func testSuggestionsSadPath() {
        
        Resolver.register { AccountsJourney.Configuration() }
        
        let viewModel = AccountDetailsViewModel()
        // Register the Mock
        Resolver.register { MockAccountDetailsUseCase(shouldReturnError: true) as AccountDetailsUseCase }
        
        let viewController = AccountDetailsViewController(viewModel: viewModel, arrangementId: "")
        
        // fire the event that fetches account details
        viewController.viewModel.onEvent(.getAccountDetails(""))
        
        let result = verifyViewSnapshot(with: viewController.view)
        XCTAssertTrue(result.isEmpty, "Failed in \(#function) snapshot test")
        
    }
}
