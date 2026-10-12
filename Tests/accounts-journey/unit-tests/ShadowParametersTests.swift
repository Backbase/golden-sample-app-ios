import BackbaseDesignSystem
import Testing
@testable import AccountsJourney

@Suite("ShadowStyleModifier.ShadowParameters")
struct ShadowParametersTests {

    @Test
    func designSystemShadow_isMappedToTheShadowParameters() {
        let shadow = DesignSystem.shared.shadows.small

        let parameters = ShadowStyleModifier.ShadowParameters.designSystem(shadow)

        #expect(parameters.radius == shadow.radius)
        #expect(parameters.x == shadow.offset.width)
        #expect(parameters.y == shadow.offset.height)
    }

    @Test
    func cardView_usesTheSmallShadowOfTheDesignSystem() {
        let small = DesignSystem.shared.shadows.small

        let parameters = ShadowStyleModifier.ShadowParameters.cardView

        #expect(parameters.radius == small.radius)
        #expect(parameters.y == small.offset.height)
    }
}
