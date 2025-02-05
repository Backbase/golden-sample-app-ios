import Foundation
import RetailMoreJourney
import Resolver
import AppCommon
import BackbaseDesignSystem
import IdentityAuthenticationJourney

struct MoreMenuConfiguration: AppCommon.AppDependency {
    
    func register() {
        Resolver.register { self }.scope(Resolver.cached)
    }

    private static var demoSection: More.MenuSection {
        let securityItems: [More.MenuItem] = [
            .init(
                title: .init(key: "retailUniversalApp.more.items.demo", in: .appCommon),
                icon: UIImage(systemName: "d.square"),
                iconBackgroundColor: DesignSystem.shared.colors.primary.default,
                iconTintColor: DesignSystem.shared.colors.primary.onDefault,
                action: { navigationController in
                    navigationController.pushViewController(DemoViewController(title: "Demo"), animated: true)
                }
            )
        ]
        return .init(title: nil, items: securityItems)
    }

    private static var securitySection: More.MenuSection {
        let securityItems: [More.MenuItem] = [
            .init(
                title: .init(key: "retailUniversalApp.more.items.logout", in: .appCommon),
                icon: UIImage(systemName: "iphone.and.arrow.forward"),
                iconBackgroundColor: DesignSystem.shared.colors.danger.default,
                iconTintColor: DesignSystem.shared.colors.primary.onDefault,
                action: { _ in
                    let useCase: AuthenticationUseCase = Resolver.resolve()
                    useCase.endSession(callback: nil)
                }
            )
        ]
        return .init(title: nil, items: securityItems)
    }
}

extension MoreMenuConfiguration: AppCommon.Configurable {
    static var appDefault: More.Configuration {
        let menu = More.Menu(deferredSections: [demoSection, securitySection])
        var configuration = More.Configuration()
        configuration.analytics.journeyName = "more_menu"
        configuration.analytics.screenLabel = "more_menu"
        configuration.menu = menu
        configuration.design.shouldAlwaysBounceVertically = true
        return configuration
    }
}
