//
//  CustomRouter.swift
//  GoldenSampleApp
//
//  Created by Backbase R&D B.V. on 8/05/2025.
//

import BackbaseIdentity

class CustomRouter: BBIDRouter {
    private let strings = Strings()
    private let context: BBIDRouterContext
    private let testWindow: UIWindow?

    weak var delegate: ErrorResponseDelegate?
    private(set) var isChallengeNotResolved: Bool = true

    init(testWindow: UIWindow?, context: BBIDRouterContext) {
        self.testWindow = testWindow
        self.context = context
    }

    // MARK: - Public

    func onSuccess(context: BBIDRouterContext, contract: BBIDRouterContract) {
        contract.finish(context: context)
    }

    func onError(
        _ errorDetails: BBIDRouterError, context: BBIDRouterContext,
        contract: BBIDRouterContract
    ) {
        contract.cancel(context: context)
        contract.cancel(error: errorDetails.error, context: context)
    }

    func setDelegate(_ delegate: ErrorResponseDelegate) {
        self.delegate = delegate
    }

    func showWindow(request: URLRequest) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let alert = UIAlertController(
                title: strings.alertTitle(),
                message: strings.alertMessage(),
                preferredStyle: .alert
            )

            alert.addAction(self.makeCloseAction())
            alert.addAction(self.makeContinueAction(request: request))

            self.testWindow?.rootViewController?.present(alert, animated: true)
        }
    }
}

// MARK: - Private

extension CustomRouter {

    fileprivate func makeCloseAction() -> UIAlertAction {
        return UIAlertAction(title: strings.closeButton(), style: .cancel) {
            [weak self] _ in
            self?.delegate?.requestDidFail()
        }
    }

    fileprivate func makeContinueAction(request: URLRequest) -> UIAlertAction {
        return UIAlertAction(title: strings.continueButton(), style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.resolveChallenge(request: request)
            self.isChallengeNotResolved = false
        }
    }

    private func resolveChallenge(request: URLRequest) {
        URLSession.shared.dataTask(with: request) {
            [weak self] data, response, error in
            guard let self = self else { return }

            if let error = error {
                delegate?.requestDidAbort(with: error)
            } else if let data = data, let response = response {
                delegate?.requestDidSucceed(with: response, data: data)
            } else {
                delegate?.requestDidFail()
            }
        }.resume()
    }
}
