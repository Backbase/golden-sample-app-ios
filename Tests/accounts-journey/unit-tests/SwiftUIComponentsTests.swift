import XCTest
import SwiftUI
import UIKit
import BackbaseDesignSystem
@testable import AccountsJourney

// MARK: - Grouped row corners

final class GroupedRowCornersTests: XCTestCase {

    func test_position_isFull_whenThereIsASingleRow() {
        XCTAssertEqual(CellPosition.position(forRow: 0, count: 1), .full)
        XCTAssertEqual(CellPosition.position(forRow: 0, count: 0), .full)
    }

    func test_position_isBeginningMiddleEnd_forSeveralRows() {
        XCTAssertEqual(CellPosition.position(forRow: 0, count: 3), .beginning)
        XCTAssertEqual(CellPosition.position(forRow: 1, count: 3), .middle)
        XCTAssertEqual(CellPosition.position(forRow: 2, count: 3), .end)
    }

    func test_position_isBeginningAndEnd_forTwoRows() {
        XCTAssertEqual(CellPosition.position(forRow: 0, count: 2), .beginning)
        XCTAssertEqual(CellPosition.position(forRow: 1, count: 2), .end)
    }

    func test_cornerRadii_roundOnlyTheCornersOfTheUIKitMask() {
        let radius: CGFloat = 12

        let beginning = CellPosition.beginning.cornerRadii(radius: radius)
        XCTAssertEqual(beginning.topLeading, radius)
        XCTAssertEqual(beginning.topTrailing, radius)
        XCTAssertEqual(beginning.bottomLeading, 0)
        XCTAssertEqual(beginning.bottomTrailing, 0)

        let end = CellPosition.end.cornerRadii(radius: radius)
        XCTAssertEqual(end.topLeading, 0)
        XCTAssertEqual(end.topTrailing, 0)
        XCTAssertEqual(end.bottomLeading, radius)
        XCTAssertEqual(end.bottomTrailing, radius)

        let full = CellPosition.full.cornerRadii(radius: radius)
        XCTAssertEqual([full.topLeading, full.topTrailing, full.bottomLeading, full.bottomTrailing], [radius, radius, radius, radius])

        let middle = CellPosition.middle.cornerRadii(radius: radius)
        XCTAssertEqual([middle.topLeading, middle.topTrailing, middle.bottomLeading, middle.bottomTrailing], [0, 0, 0, 0])
    }
}
