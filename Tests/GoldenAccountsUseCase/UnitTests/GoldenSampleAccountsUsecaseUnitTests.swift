//
//  GoldenSampleAccountsUsecaseUnitTests.swift
//  GoldenSampleAppTests
//
//  Created by Backbase R&D B.V. on 13/10/2023.
//

import XCTest
import Foundation
import ArrangementsClient2Gen2
import AccountsJourney
import GoldenAccountsUseCase

final class GoldenSampleAccountsMappersUnitTests: XCTestCase {
    func test_UserPreferences_toDomainModel_mapping() {
        var sut = ArrangementsClient2Gen2.UserPreferences.Builder()
            .set(alias: "IamAnAlias")
            .set(visible: true)
            .set(favorite: true)
            .set(additions: ["available":"yes"])
            .build()
        
        
        let expectedOutcome = AccountsJourney.UserPreferences(alias: "IamAnAlias", visible: true, favorite: true, additions: ["available":"yes"])
        
        XCTAssertEqual(sut.toDomainModel(), expectedOutcome)
    }
}
