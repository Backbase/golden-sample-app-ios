import Foundation
import Alamofire
import Backbase

final class CustomAccountsUseCase {

    enum AccountsUseCaseError: Error {
        case internalError
        case networkError
    }

    private var session: Session = {
        var serverTrustManager: ServerTrustManager?
        if !Bundle.main.af.certificates.isEmpty,
            let serverUrlString = Backbase.configuration().backbase.serverURL,
            let url = URL(string: serverUrlString),
            let host = url.host {
            let evaluators: [String: ServerTrustEvaluating] = [
                host: PinnedCertificatesTrustEvaluator(certificates: Bundle.main.af.certificates,
                                                       acceptSelfSignedCertificates: false,
                                                       performDefaultValidation: true,
                                                       validateHost: true)
            ]
            serverTrustManager = ServerTrustManager(allHostsMustBeEvaluated: true, evaluators: evaluators)
        }
        return Session(serverTrustManager: serverTrustManager)
    }()

    private var url: URL {
        guard let serverUrl = Backbase.configuration().backbase.serverURL else { fatalError() }
        let path = "/api/arrangement-manager/client-api/v2/productsummary"
        return URL(string: serverUrl + path)!
    }

    private var deviceUserAgent: String {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let model = UIDevice.current.model
        let system = UIDevice.current.systemName
        let systemVersion = UIDevice.current.systemVersion.replacingOccurrences(of: ".", with: "_")

        return "CxpMobile/11.0.1 \(model);\(system) \(systemVersion); \(model) \(appName)/\(appVersion)"
    }

    func getAccounts() async throws -> AccountsJourney.AccountsSummary {

        let urlRequest = try createRequest()

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let response = await session.request(urlRequest)
            .serializingDecodable(AccountsJourney.AccountsSummary.self, decoder: decoder)
            .response

        switch response.result {
            case .success(let accounts):
                return accounts
            case .failure:
                throw AccountsUseCaseError.networkError
            }
    }
    
    private func createRequest() throws -> URLRequest {
        var request = try URLRequest(url: url, method: .get)

        guard let authorizationHeader = Backbase.authClient().tokens()["Authorization"] else {
            throw AccountsUseCaseError.internalError
        }

        request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        request.setValue(deviceUserAgent, forHTTPHeaderField: "User-Agent")

        return request
    }
}
