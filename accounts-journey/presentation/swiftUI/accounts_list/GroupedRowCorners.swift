//
//  GroupedRowCorners.swift
//  AccountsJourney
//

import SwiftUI

/// SwiftUI replacement of the UIKit `CellCornerModifier`.
///
/// Rounds the corners of a row depending on its position in a grouped list, so
/// consecutive rows look like a single rounded card.
struct GroupedRowCorners: ViewModifier {

    let position: CellPosition

    func body(content: Content) -> some View {
        content.clipShape(UnevenRoundedRectangle(cornerRadii: position.cornerRadii(), style: .circular))
    }
}

extension View {
    /// Rounds the row corners according to its `position` in a grouped list.
    func groupedRowCorners(_ position: CellPosition) -> some View {
        modifier(GroupedRowCorners(position: position))
    }
}
