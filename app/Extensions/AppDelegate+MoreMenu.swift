import Foundation
import RetailMoreJourney
import Resolver

extension AppDelegate {

    func setupMoreMenu() {
        Resolver.register { AppDelegate.appDefault }
    }

    static var appDefault: More.Configuration {
        let menu = More.Menu(deferredSections: buildSections())
        var configuration = More.Configuration()
        configuration.analytics.journeyName = "more_menu"
        configuration.analytics.screenLabel = "more_menu"
        configuration.menu = menu
        configuration.design.shouldAlwaysBounceVertically = true
        return configuration
    }

    private static func buildSections() -> [More.MenuSection] {
        var sections = [More.MenuSection?]()
/*            sections.append(contentsOf: [buildFinancialInsightsSection(),
                                         buildSettingsSection()])
        }
        sections.append(contentsOf: [buildContactUsSection(),
                                     buildManageSection()])
        if !useTabbedHeader {
            sections.append(buildSecuritySection())
        }*/
        return sections.compactMap { $0 }
    }

}
