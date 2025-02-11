import Foundation
import RetailMoreJourney
import Resolver
import AppCommon
import BackbaseDesignSystem
import IdentityAuthenticationJourney
import RetailContactsJourney

extension More.Configuration: AppCommon.AppDependency {
    public func register() {
        Resolver.register { self }.scope(Resolver.cached)
    }
    
    private static var contactsSection: More.MenuSection {
        let contactsItems: [More.MenuItem] = [
            .init(
                title: .init(key: "goldenSampleApp.more.items.contacts", in: .appCommon),
                icon: UIImage(systemName: "book.pages"),
                iconBackgroundColor: DesignSystem.shared.colors.primary.default,
                iconTintColor: DesignSystem.shared.colors.primary.onDefault,
                action: { navigationController in
                    navigationController.pushViewController(RetailContactsJourney.ContactList.build(navigationController: navigationController), animated: true)
                }
            )
        ]
        return .init(title: nil, items: contactsItems)
    }
    
    private static var demoSection: More.MenuSection {
        let securityItems: [More.MenuItem] = [
            .init(
                title: .init(key: "goldenSampleApp.more.items.demo", in: .appCommon),
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
                title: .init(key: "goldenSampleApp.more.items.logout", in: .appCommon),
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

extension More.Configuration: AppCommon.Configurable {
    public static var appDefault: More.Configuration {
        let menu = More.Menu(showSeparators: false, deferredSections: [contactsSection, demoSection, securitySection])
        var configuration = More.Configuration()
        configuration.analytics.journeyName = "more_menu"
        configuration.analytics.screenLabel = "more_menu"
        configuration.menu = menu
        configuration.design.shouldAlwaysBounceVertically = true
        return configuration
    }
}
