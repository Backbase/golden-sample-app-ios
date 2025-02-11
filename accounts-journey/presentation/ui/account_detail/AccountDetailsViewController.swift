//
//  AccountDetailsViewController.swift
//  AccountsJourney
//
//  Created by Backbase R&D B.V. on 29/11/2023.
//

import UIKit
import Combine
import Resolver
import BackbaseDesignSystem

final class AccountDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: AccountDetailsViewModel
    private var arrangementId: String
    private var cancellables = Set<AnyCancellable>()
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    
    // MARK: - UI Properties
    private var stateView: StateView?
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let header = SummaryStackView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [header])
        stackView.spacing = DesignSystem.shared.spacer.sm
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - Init
    init(viewModel: AccountDetailsViewModel, arrangementId: String) {
        self.viewModel = viewModel
        self.arrangementId = arrangementId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    override func loadView() {
        super.loadView()
        [scrollView, loadingView ].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(stackView)
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onEvent(.getAccountDetails(arrangementId))
        viewDidAppearSubject.send()
    }
    
    private func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        scrollView.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.accountDetails.strings.screenTitle()
        
        if let navigationBar = navigationController?.navigationBar {
            configuration.accountDetails.design.styles.navigationBar(navigationBar)
            navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
                title: configuration.accountDetails.strings.backButtonTitle(),
                style: .plain,
                target: nil,
                action: nil
            )
        }
        
        configuration.accountDetails.design.styles.navigationItem(navigationItem)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // StackView
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: DesignSystem.shared.spacer.sm),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -DesignSystem.shared.spacer.md),
            
            // LoadingView
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.bind(
            viewDidAppear: viewDidAppearSubject.eraseToAnyPublisher()
        )
        
        viewModel
            .$screenState
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                switch state {
                case .loading:
                    self?.showLoadingView()
                case let .loaded(details):
                    self?.hideLoadingView()
                    self?.updateDetailsView(details)
                case let .hasError(errorStateConfiguration):
                    self?.showStateView(errorStateConfiguration)
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    private func updateDetailsView(_ details: AccountDetailsUIModel) {
        // MARK: - Header start
        var summaryStackRows = [SummaryStackRow]()
        if let iconName = details.iconName {
            summaryStackRows.append(SummaryStackIconRow(iconName.icon, iconSize: CGSize(width: 40, height: 40)))
        }
        summaryStackRows.append(SummaryStackTextRow(primaryTextRow: details.productKindName))
        summaryStackRows.append(SummaryStackTextRow(secondaryTextRow: details.BBAN))
        // MARK: Amount
        summaryStackRows.append(SummaryStackTextRow(amount: Decimal(details.availableBalance)))
        summaryStackRows.append(SummaryStackTextRow(amount: Decimal(details.creditLimit), amountTextRow: configuration.accountDetails.strings.limitTitle()))
        header.rows = summaryStackRows
        
        // MARK: - Sections
        let detailsView = AccountDetailsUsageView()
        let generalView = AccountDetailsUsageView()
        let statusView = AccountDetailsUsageView()
        
        // Update information
        detailsView.updateView(with: prepareDetailsSection(from: details))
        generalView.updateView(with: prepareGeneralSection(from: details))
        statusView.updateView(with: prepareStatusSection(from: details))
        
        stackView.addArrangedSubview(detailsView)
        stackView.addArrangedSubview(generalView)
        stackView.addArrangedSubview(statusView)
    }
    
    private func prepareDetailsSection(from details: AccountDetailsUIModel) -> AccountDetailsSection {
        AccountDetailsSection(
            title: " ",
            rows: [
                AccountDetailsRowItem(
                    title: .text(
                        configuration.accountDetails.strings.holderNamesTitle(),
                        configuration.accountDetails.design.styles.accountDetailRowItemTitle
                    ),
                    subTitle: .text(
                        details.displayName,
                        configuration.accountDetails.design.styles.accountDetailRowItemSubtitle)
                ),
                AccountDetailsRowItem(
                    title: .text(
                        configuration.accountDetails.strings.cardOrAccountNumberTitle(),
                        configuration.accountDetails.design.styles.accountDetailRowItemTitle
                    ),
                    subTitle: .text(
                        details.BBAN,
                        configuration.accountDetails.design.styles.accountDetailRowItemSubtitle)
                )
            ])
    }
    
    private func prepareGeneralSection(from details: AccountDetailsUIModel) -> AccountDetailsSection {
        AccountDetailsSection(
            title: configuration.accountDetails.strings.generalSectionTitle(),
            rows: [
                AccountDetailsRowItem(
                    title: .text(
                        configuration.accountDetails.strings.accountTypeTitle(),
                        configuration.accountDetails.design.styles.accountDetailRowItemTitle
                    ),
                    subTitle: .text(
                        details.productKindName,
                        configuration.accountDetails.design.styles.accountDetailRowItemSubtitle)
                ),
                AccountDetailsRowItem(
                    title: .text(
                        configuration.accountDetails.strings.accountNameTitle(),
                        configuration.accountDetails.design.styles.accountDetailRowItemTitle
                    ),
                    subTitle: .text(
                        details.productKindName,
                        configuration.accountDetails.design.styles.accountDetailRowItemSubtitle
                    )
                )
            ])
    }
    
    private func prepareStatusSection(from details: AccountDetailsUIModel) -> AccountDetailsSection {
        AccountDetailsSection(
            title: configuration.accountDetails.strings.statusSectionTitle(),
            rows: [
                AccountDetailsRowItem(
                    title: .text(
                        configuration.accountDetails.strings.accountStatusTitle(),
                        configuration.accountDetails.design.styles.accountDetailRowItemTitle
                    ),
                    subTitle: .text(
                        details.accountState ?? "",
                        configuration.accountDetails.design.styles.accountDetailRowItemSubtitle
                    )
                )
            ]
        )
    }
    
    private func showLoadingView() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    private func hideLoadingView() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
    
    private func showStateView(_ configuration: StateViewConfiguration){
        stateView = StateView(params: StateViewInitParams(configuration: configuration, bundles: .accountsJourney ?? .design ?? .main))
        guard let stateView else { return }
        stateView.accessibilityIdentifier = "AccountDetailsStateView"
        
        view.addSubview(stateView)
        
        NSLayoutConstraint.activate([
            stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: DesignSystem.shared.spacer.md),
            stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -DesignSystem.shared.spacer.md),
            stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func removeStateView() {
        if stateView != nil {
            UIView.animate(withDuration: 0.2) {
                self.stateView?.alpha = 0.0
            } completion: { _ in
                self.stateView?.removeFromSuperview()
                self.stateView = nil
            }
        }
    }
}
