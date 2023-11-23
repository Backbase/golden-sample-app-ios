//
//  AccountsJourneyErrorMapper.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 13/11/2023.
//

import Foundation
import BackbaseDesignSystem

final class AccountsJourneyErrorMapper {
    typealias Action = (() -> Void)
    
    private let loadingFailedAction: Action
    private let notConnectedAction: Action
    private let genericAction: Action
    
    init(
        loadingFailedAction: @escaping AccountsJourneyErrorMapper.Action,
        notConnectedAction: @escaping AccountsJourneyErrorMapper.Action,
        genericAction: @escaping AccountsJourneyErrorMapper.Action
    ) {
        self.loadingFailedAction = loadingFailedAction
        self.notConnectedAction = notConnectedAction
        self.genericAction = genericAction
    }
    
    func mapToStateViewConfiguration(error: Error) -> StateViewConfiguration {
        let journeyError = error as? AccountsJourney.Error ?? AccountsJourney.Error.loadingFailure()
        
        switch journeyError {
        case .loadingFailure:
            return LoadingFailureStateViewConfiguration(
                title: journeyError.title,
                subtitle: journeyError.subtitle,
                buttonConfiguration: .init(
                    title: journeyError.actionButtonTitle ?? "",
                    action: { [weak self ] in
                    self?.loadingFailedAction()
                })
            )
        case .notConnected:
            return NoConnectionStateViewConfiguration(
                title: journeyError.title,
                subtitle: journeyError.subtitle,
                buttonConfiguration: .init(
                    title: journeyError.actionButtonTitle ?? "",
                    action: { [weak self] in
                        self?.notConnectedAction()
                })
            )
        default:
            return LoadingFailureStateViewConfiguration(
                title: journeyError.title,
                subtitle: journeyError.subtitle,
                buttonConfiguration: .init(
                    title: journeyError.actionButtonTitle ?? "",
                    action: {[weak self] in
                        self?.genericAction()
                    })
            )
        }
    }
}

