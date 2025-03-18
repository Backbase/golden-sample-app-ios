import BackbaseObservability

struct APIRequestEvent {
    let url: String
    let httpMethod: String
    let body: String?
    let httpHeaderFields: [String: String]?
}

struct APIResponseEvent {
    let url: String
    let statusCode: Int
    let requestRoundTrip: Double
    let httpHeaderFields: [String: String]?
}
