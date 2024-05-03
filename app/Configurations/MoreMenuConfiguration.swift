import Foundation
import RetailMoreJourney
import Resolver
import BackbaseDesignSystem
import IdentityAuthenticationJourney

struct MoreMenuConfiguration {

    private static var demoSection: More.MenuSection {
        let securityItems: [More.MenuItem] = [
            .init(
                title: .init(key: "retailUniversalApp.more.items.demo", in: .app),
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
                title: .init(key: "retailUniversalApp.more.items.logout", in: .app),
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

    static func setupMoreMenu() {
        Resolver.register { appDefault }
    }

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

// This is needed by the More Menu configuration
private extension Bundle {
    static var app: Bundle? {
        let podBundle = Bundle(for: BundleToken.self)
        guard let resourceUrl = podBundle.url(forResource: "Assets", withExtension: "bundle") else { return podBundle }
        guard let resourceBundle = Bundle(url: resourceUrl) else { return podBundle }
        return resourceBundle
    }
}

private final class BundleToken { }
