////
////  AppDelegate+Identity.swift
////  GoldenSampleApp
////
////  Created by Backbase R&D B.V. on 13/10/2023.
////
//
//import UIKit
//import Resolver
//import Backbase
//import IdentityAuthenticationJourney
//import BusinessWorkspacesJourney
//import BusinessWorkspacesJourneyWorkspacesUseCase2
//import BusinessJourneyCommon
//import RetailFeatureFilterUseCase
//import RetailFeatureFilterAccessControlEntitlementsUseCase
//import AccessControlClient3Gen2
//
//extension AppDelegate {
//    
//    func setupIdentityJourney() {
//        Resolver.register { self.navCoordinator as AuthenticationNavigationCoordinator }
//        authenticationUseCase.validateSession()
//    }
//    
//    func handleSessionChange(newSession session: Session) {
//        DispatchQueue.main.async {
//            let windowViewController: UIViewController
//            let navigationController = UINavigationController()
//            
//            switch session {
//            case .valid:
//                windowViewController = Workspaces.buildSelector(navigationController: navigationController)
//            case .none:
//                if self.authenticationUseCase.isEnrolled {
//                    windowViewController = Login.build(shouldAutoLogin: true)(navigationController)
//                } else {
//                    windowViewController = Register.build()(navigationController)
//                }
//            case .locked:
//                windowViewController = Register.build(session: .locked)(navigationController)
//            case .expired:
//                windowViewController = Login.build(session: .expired)(navigationController)
//            @unknown default:
//                fatalError()
//            }
//            navigationController.viewControllers = [windowViewController]
//            self.window?.rootViewController = navigationController
//        }
//    }
//}
