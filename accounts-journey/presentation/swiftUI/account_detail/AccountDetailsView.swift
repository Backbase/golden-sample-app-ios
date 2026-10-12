//
//  AccountDetailsView.swift
//  AccountsJourney
//

import BackbaseDesignSystem
import Combine
import Resolver
import SwiftUI

/// SwiftUI replacement of `AccountDetailsViewController`.
///
/// Shares `AccountDetailsViewModel` with the UIKit screen. This view owns what is specific to
/// SwiftUI: loading the details when it appears and the analytics subject the view model binds to.
struct AccountDetailsView: View {

    @ObservedObject private var viewModel: AccountDetailsViewModel
    private let arrangementId: String
    private let configuration: AccountsJourney.Configuration

    @State private var hasStarted = false
    @State private var viewDidAppearSubject = PassthroughSubject<Void, Never>()

    init(
        viewModel: AccountDetailsViewModel,
        arrangementId: String,
        configuration: AccountsJourney.Configuration = Resolver.resolve()
    ) {
        self.viewModel = viewModel
        self.arrangementId = arrangementId
        self.configuration = configuration
    }

    var body: some View {
        AccountDetailsContentView(state: viewModel.screenState, strings: configuration.accountDetails.strings)
            .background(Color(Theme.colors.background.page).ignoresSafeArea())
            .navigationTitle(configuration.accountDetails.strings.screenTitle())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: onAppear)
    }

    // MARK: - Private

    /// The view model is bound once, the details are requested every time the screen appears.
    private func onAppear() {
        if !hasStarted {
            hasStarted = true
            viewModel.bind(viewDidAppear: viewDidAppearSubject.eraseToAnyPublisher())
        }
        viewModel.onEvent(.getAccountDetails(arrangementId))
        viewDidAppearSubject.send()
    }
}

// MARK: - Content

/// The screen for a given state. It knows nothing about the view model, which keeps it previewable.
private struct AccountDetailsContentView: View {

    let state: AccountDetailsScreenState
    let strings: AccountDetails.Strings

    var body: some View {
        switch state {
        case .loading:
            CustomProgressView()
                .padding(.horizontal, DesignSystem.shared.spacer.md)
        case let .loaded(details):
            AccountDetailsLoadedView(details: details, strings: strings)
        case let .hasError(stateConfiguration):
            StateConfigurationView(
                configuration: stateConfiguration,
                appearance: EmblemAppearance.appearance(forBackground: Theme.colors.background.dangerSubtle),
                accessibilityIdentifier: "AccountDetailsStateView"
            )
            .padding(.horizontal, DesignSystem.shared.spacer.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

/// The header followed by the details, general and status sections.
private struct AccountDetailsLoadedView: View {

    let details: AccountDetailsUIModel
    let strings: AccountDetails.Strings

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AccountDetailsHeaderView(content: AccountDetailsHeaderContent(details: details, strings: strings))
                AccountDetailsSectionView(content: .details(for: details, strings: strings))
                AccountDetailsSectionView(content: .general(for: details, strings: strings))
                AccountDetailsSectionView(content: .status(for: details, strings: strings))
            }
            .padding(.top, DesignSystem.shared.spacer.sm)
            .padding(.bottom, DesignSystem.shared.spacer.md)
        }
    }
}

// MARK: - Previews

#if DEBUG
private enum AccountDetailsPreviewData {

    static let details = AccountDetailsUIModel(
        id: "1",
        name: "Main account",
        displayName: "John Doe",
        BBAN: "****************0025",
        currency: "EUR",
        availableBalance: 3207.61,
        accountHolderNames: "John Doe",
        productKindName: "Current Account",
        productTypeName: "Current Account",
        bankBranchCode: nil,
        lastUpdateDate: "",
        accountInterestRate: nil,
        accruedInterest: 0,
        creditLimit: 1055.5,
        accountOpeningDate: "",
        accountState: "Active",
        iconName: AccountIconInfo(
            icon: UIImage(systemName: "creditcard") ?? UIImage(),
            backgroundColor: Theme.colors.background.brandSubtle
        )
    )

    static let error: StateViewConfiguration = GenericStateViewConfiguration(
        iconName: DesignSystem.Assets.icStateViewLoadingFailed,
        title: "Something went wrong",
        subtitle: "We couldn't load the account details.",
        firstButtonConfiguration: ButtonConfiguration(title: "Try again", action: {})
    )
}

private struct AccountDetailsPreview: View {

    let state: AccountDetailsScreenState

    var body: some View {
        NavigationStack {
            AccountDetailsContentView(state: state, strings: AccountDetails.Strings())
                .background(Color(Theme.colors.background.page).ignoresSafeArea())
                .navigationTitle("Account details")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("Loaded") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountDetailsPreview(state: .loaded(AccountDetailsPreviewData.details))
}

#Preview("Loading") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountDetailsPreview(state: .loading)
}

#Preview("Error") {
    Resolver.register { AccountsJourney.Configuration() }
    return AccountDetailsPreview(state: .hasError(AccountDetailsPreviewData.error))
}
#endif
