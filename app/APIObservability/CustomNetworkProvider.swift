import Backbase
import BackbaseObservability
import Resolver

class CustomNetworkDataProvider: NSObject, DBSDataProvider {

    private var tracker: BackbaseObservability.Tracker? = Resolver.optional()

    func execute(_ request: URLRequest, completionHandler: ((URLResponse?, Data?, Error?) -> Void)? = nil) {
        let requestStartTime = Date()
        tracker?.publish(event: APIRequestEvent(url: request.url!.absoluteString,
                                                httpMethod: request.httpMethod ?? "GET",
                                                body: String(data: request.httpBody ?? Data(), encoding: .utf8),
                                                httpHeaderFields: request.allHTTPHeaderFields))
        URLSession(configuration: Backbase.securitySessionConfiguration(),
                   delegate: nil,
                   delegateQueue: nil).dataTask(with: request) { [weak self] data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                self?.tracker?.publish(event: APIResponseEvent(url: httpResponse.url!.absoluteString,
                                                         statusCode: httpResponse.statusCode,
                                                         requestRoundTrip: Date().timeIntervalSince(requestStartTime),
                                                         httpHeaderFields: httpResponse.allHeaderFields as? [String: String]))
            }
            DispatchQueue.main.async {
                completionHandler?(response, data, error)
            }
        }.resume()
    }
}
