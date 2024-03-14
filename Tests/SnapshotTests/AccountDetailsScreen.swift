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

private extension Bundle {
    static func data(from path: String) -> Data {
        guard let filePath = Bundle(for: AccountDetailsScreenSnapshotTests.self).path(forResource: path, ofType: nil) else {
            fatalError("Failed to find file \(path)")
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        do {
            let data = try Data(contentsOf: fileUrl, options: .uncached)
            return data
        } catch {
            fatalError("Failed to find file \(path)")
        }
    }
}


class MockAccountDetailsUseCase: AccountDetailsUseCase {
    private var shouldReturnError = false
    private var fileName: String
    
    init(shouldReturnError: Bool = false, fileName: String = "arrangement.json") {
        self.shouldReturnError = shouldReturnError
        self.fileName = fileName
    }
    
    func getAccountDetail(
        arrangementId: String,
        _ completion: @escaping (Result<AccountsJourney.AccountDetailsModel, AccountsJourney.ErrorResponse>) -> Void) {
        if shouldReturnError {
            completion(.failure(AccountsJourney.ErrorResponse(statusCode: 404, data: nil, error: AccountDetails.Error.invalidResponse)))
        } else {
            let data = Bundle.data(from: fileName)
            
            guard let arrangementDetails = try? JSONDecoder().decode(ArrangementsClient2Gen2.AccountArrangementItem.self, from: data) else {
                completion(.failure(.init()))
                return
            }
            
            completion(.success(arrangementDetails.toDomainModel()))
        }
    }
       
}

