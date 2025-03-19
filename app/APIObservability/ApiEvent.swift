import BackbaseObservability

struct APIRequestEvent {
    let requestId: String
    let url: String
    let httpMethod: String
    let body: String?
    let httpHeaderFields: [String: String]?
}

struct APIResponseEvent {
    let requestId: String
    let url: String
    let statusCode: Int
    let requestRoundTripTime: Double
    let httpHeaderFields: [String: String]?
}
