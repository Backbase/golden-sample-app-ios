//
//  CustomStepUpResolver.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 8/05/2025.
//

import BackbaseIdentity

final class CustomStepUpResolver: NSObject, ErrorResponseResolver {

    // MARK: - Properties

    private let keyDeviceSignature = "device-signature"

    private var client: BBIDAuthClient
    private var testWindow: UIWindow?
    weak var router: CustomRouter?

    // MARK: - Init

    init(client: BBIDAuthClient, testWindow: UIWindow?) {
        self.client = client
        self.testWindow = testWindow
    }

    // MARK: - ErrorResponseResolver Conformance

    func handle(
        _ response: URLResponse, data: Data, from request: URLRequest,
        delegate: any ErrorResponseDelegate & NSObjectProtocol
    ) {
        let message = String(data: data, encoding: .utf8)
        if message?.contains(keyDeviceSignature) == true {
            router = client.routers(ofType: CustomRouter.self).first
            router?.setDelegate(delegate)
            router?.showWindow(request: request)
        }
    }

    func canHandle(
        _ response: URLResponse, data: Data, from request: URLRequest
    ) -> Bool {
        let message = String(data: data, encoding: .utf8)
        if message?.contains(keyDeviceSignature) == true {
            return router?.isChallengeNotResolved ?? true
        }
        return false
    }
}
