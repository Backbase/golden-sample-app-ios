//
//  AccountsSearchBar.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Resolver
import SwiftUI

/// SwiftUI replacement of `AccountListSearchBarHeaderView`.
struct AccountsSearchBar: View {

    @Binding var text: String

    /// Owned by the parent, so the screen can dismiss the keyboard.
    private let isFocused: FocusState<Bool>.Binding

    private let placeholder: String
    private let clearButtonLabel: String
    private let textColor: Color
    private let tintColor: Color
    private let iconColor: Color

    init(
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding,
        placeholder: String? = nil,
        textColor: Color = Color(Theme.colors.foreground.default),
        tintColor: Color = Color(Theme.colors.foreground.default),
        iconColor: Color = Color(Theme.colors.foreground.support),
        configuration: AccountsJourney.Configuration = Resolver.resolve()
    ) {
        self._text = text
        self.isFocused = isFocused
        self.placeholder = placeholder ?? configuration.accountsList.strings.searchText()
        self.clearButtonLabel = configuration.accountsList.strings.clearSearchText()
        self.textColor = textColor
        self.tintColor = tintColor
        self.iconColor = iconColor
    }

    var body: some View {
        HStack(spacing: DesignSystem.shared.spacer.sm) {
            Image.named(DesignSystem.Assets.icSearch, in: .design)
                .renderingMode(.template)
                .foregroundStyle(iconColor)
                .accessibilityHidden(true)

            TextField(
                text: $text,
                prompt: Text(placeholder).foregroundStyle(.gray)
            ) {
                Text(placeholder)
            }
                .focused(isFocused)
                .foregroundStyle(textColor)
                .tint(tintColor)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.return)
                .accessibilityIdentifier("AccountsListSearchField")

            if !text.isEmpty {
                Button {
                    text = ""
                    isFocused.wrappedValue = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(iconColor)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(clearButtonLabel)
            }
        }
        .padding(.vertical, DesignSystem.shared.spacer.sm)
        .modifier(SearchFieldBackground())
        .contentShape(Rectangle())
        .onTapGesture { isFocused.wrappedValue = true }
        .padding(.horizontal, DesignSystem.shared.spacer.sm)
        .padding(.bottom, DesignSystem.shared.spacer.md)
    }
}

/// The search field background, matching what `UISearchBarTextField` draws on each OS:
/// a Liquid Glass capsule on iOS 26+, and the system tertiary fill (`tertiarySystemFill`,
/// which adapts to light and dark mode) in a rounded rectangle before that.
private struct SearchFieldBackground: ViewModifier {

    func body(content: Content) -> some View {
        #if compiler(>=6.2)
        if #available(iOS 26, *) {
            content
                .padding(.horizontal, DesignSystem.shared.spacer.md)
                .glassEffect(.regular, in: .capsule)
        } else {
            filled(content)
        }
        #else
        filled(content)
        #endif
    }

    private func filled(_ content: Content) -> some View {
        content
            .padding(.horizontal, DesignSystem.shared.spacer.sm)
            .background(
                .fill.tertiary,
                in: RoundedRectangle(cornerRadius: DesignSystem.shared.spacer.lg, style: .continuous)
            )
    }
}

#if DEBUG
#Preview("Empty") {
    @Previewable @State var text = ""
    @Previewable @FocusState var isFocused: Bool
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsSearchBar(text: $text, isFocused: $isFocused)
        .background(Color(Theme.colors.background.page))
}

#Preview("With text") {
    @Previewable @State var text = "Savings"
    @Previewable @FocusState var isFocused: Bool
    Resolver.register { AccountsJourney.Configuration() }
    return AccountsSearchBar(text: $text, isFocused: $isFocused)
        .background(Color(Theme.colors.background.page))
}
#endif
