import BackbaseDesignSystem
import SwiftUI
import Testing
import UIKit
@testable import AccountsJourney

@Suite("EmblemAppearance")
struct EmblemAppearanceTests {

    @Test
    func nilColor_isNeutral() {
        #expect(EmblemAppearance.appearance(for: nil) == .neutral)
    }

    @Test
    func unknownColor_isNeutral() {
        #expect(EmblemAppearance.appearance(for: Color(red: 0.123, green: 0.456, blue: 0.789)) == .neutral)
    }

    @Test("Design system tokens map to their appearance", arguments: [
        (Color(Theme.colors.background.brandSubtle), BB.Emblem.Appearance.brand),
        (Color(Theme.colors.background.successSubtle), .success),
        (Color(Theme.colors.background.category2Subtle), .category2),
        (Color(Theme.colors.background.category5Subtle), .category5)
    ])
    func knownTokens_mapToTheirAppearance(color: Color, expected: BB.Emblem.Appearance) {
        #expect(EmblemAppearance.appearance(for: color) == expected)
    }

    /// `AccountIconInfo` carries a `UIColor`; the row converts it with `Color(uiColor:)`.
    @Test
    func uiColorOfAnAccountIcon_isMatchedAfterTheConversionTheRowDoes() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: Theme.colors.background.successSubtle)

        #expect(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))) == .success)
    }

    @Test
    func iconWithoutBackgroundColor_isNeutral() {
        let info = AccountIconInfo(icon: UIImage(), backgroundColor: nil)

        #expect(EmblemAppearance.appearance(for: info.backgroundColor.map(Color.init(uiColor:))) == .neutral)
    }

    @Test
    func iconInfo_isNotEqual_whenOnlyTheBackgroundColorDiffers() {
        let icon = UIImage()
        let red = AccountIconInfo(icon: icon, backgroundColor: .red)
        let blue = AccountIconInfo(icon: icon, backgroundColor: .blue)

        #expect(red == AccountIconInfo(icon: icon, backgroundColor: .red))
        #expect(red != blue)
    }

    // MARK: UIColor overload

    @Test
    func nilBackground_isNeutral() {
        #expect(EmblemAppearance.appearance(forBackground: nil) == .neutral)
    }

    @Test("Design system UIColor tokens map to their appearance", arguments: [
        (Theme.colors.background.brandSubtle, BB.Emblem.Appearance.brand),
        (Theme.colors.background.dangerSubtle, .danger),
        (Theme.colors.background.category3Subtle, .category3)
    ])
    func knownBackgroundTokens_mapToTheirAppearance(color: UIColor, expected: BB.Emblem.Appearance) {
        #expect(EmblemAppearance.appearance(forBackground: color) == expected)
    }

    @Test
    func unknownBackground_isNeutral() {
        #expect(EmblemAppearance.appearance(forBackground: UIColor(red: 0.123, green: 0.456, blue: 0.789, alpha: 1)) == .neutral)
    }

    @Test
    func backgroundOverload_matchesTheColorOverload() {
        let uiColor = Theme.colors.background.successSubtle

        #expect(EmblemAppearance.appearance(forBackground: uiColor) == EmblemAppearance.appearance(for: Color(uiColor: uiColor)))
    }

    @Test
    func colorWithDarkModeOverride_isMatchedByItsLightValue() {
        let color = Color(UIColor(light: Theme.colors.background.brandSubtle, dark: Theme.colors.background.surface2))

        #expect(EmblemAppearance.appearance(for: color) == .brand)
    }
}
