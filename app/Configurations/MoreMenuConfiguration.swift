import Foundation
import RetailMoreJourney
import Resolver
import BackbaseDesignSystem
import IdentityAuthenticationJourney
import RetailContactsJourney

struct MoreMenuConfiguration {
    
    private static var contactsSection: More.MenuSection {
        let contactsItems: [More.MenuItem] = [
            .init(
                title: .init(key: "goldenSampleApp.more.items.contacts", in: .app),
                icon: UIImage(systemName: "book.pages"),
                iconBackgroundColor: DesignSystem.shared.colors.primary.default,
                iconTintColor: DesignSystem.shared.colors.primary.onDefault,
                action: { navigationController in
                    navigationController.pushViewController(RetailContactsJourney.ContactList.build(navigationController: navigationController), animated: true)
                }
            )
        ]
        return .init(title: "", items: contactsItems)
    }

    private static var demoSection: More.MenuSection {
        let securityItems: [More.MenuItem] = [
            .init(
                title: .init(key: "goldenSampleApp.more.items.demo", in: .app),
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
                title: .init(key: "goldenSampleApp.more.items.logout", in: .app),
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
        let menu = More.Menu(deferredSections: [contactsSection, demoSection, securitySection])
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
