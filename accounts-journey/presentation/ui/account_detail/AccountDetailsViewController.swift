//
//  AccountDetailsViewController.swift
//  AccountsJourney
//
//  Created by George Nyakundi on 29/11/2023.
//

import UIKit
import SnapKit
import Combine
import Resolver
import BackbaseDesignSystem

final class AccountDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: AccountDetailsViewModel
    private var arrangementId: String
    private var cancellables = Set<AnyCancellable>()
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    
    // MARK: - UI Properties
    private var stateView: StateView?
    private let loadingView = LoadingView()
    
    private var header = SummaryStackView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [header])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = DesignSystem.shared.spacer.sm
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
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
        view.addSubview(scrollView)
        view.addSubview(loadingView)
        
        scrollView.addSubview(stackView)
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.onEvent(.getAccountDetails(arrangementId))
    }
    
    func setupView() {
        view.backgroundColor = DesignSystem.shared.colors.foundation.default
        scrollView.backgroundColor = DesignSystem.shared.colors.foundation.default
        title = configuration.accountDetails.strings.screenTitle()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.trailing.width.equalToSuperview()
            make.top.equalToSuperview().inset(DesignSystem.shared.spacer.sm)
            make.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
        
        loadingView.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make
                .centerY
                .equalToSuperview()
        }
        
    }
    
    func setupBindings() {
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
                default:
                    break
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
        stateView.snp.makeConstraints { make in
            make
                .leading
                .trailing
                .equalToSuperview()
                .inset(DesignSystem.shared.spacer.md)
            make
                .centerY
                .equalToSuperview()
        }
    }
    
    private func removeStateView() {
        if stateView != nil {
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.stateView?.alpha = 0.0
            } completion: { [weak self] _ in
                self?.stateView?.removeFromSuperview()
                self?.stateView = nil
            }
        }
    }
}

// MARK: - Temporary holding Space
final class AccountDetailsUsageView: UIView {
    // MARK: - Properties
    let configuration: AccountsJourney.Configuration = Resolver.resolve()
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.axis = .vertical
        view.alignment = .fill
        view.spacing = DesignSystem.shared.spacer.md
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var card: Card = {
        let card = Card(DesignSystem.shared.styles.cardView)
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    // MARK: - Init
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(card)
        card.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateView(with section: AccountDetailsSection) {
        if let title = section.title {
            titleLabel.text = title.uppercased()
            configuration.accountDetails.design.styles.accountDetailSectionTitle(titleLabel)
        }
        
        for item in section.rows {
            let accountDetailUsageRow = AccountDetailsUsageRowView()
            accountDetailUsageRow.setupView(item)
            stackView.addArrangedSubview(accountDetailUsageRow)
        }
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(DesignSystem.shared.spacer.lg)
        }
        card.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(DesignSystem.shared.spacer.xs)
            make.leading.trailing.bottom.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(DesignSystem.shared.spacer.md)
        }
    }
}

final class AccountDetailsUsageRowView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = DesignSystem.shared.spacer.sm
        return view
    }()
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(_ rowItem: AccountDetailsRowItem) {
        switch rowItem.title {
        case .text(let string, let style):
            titleLabel.text = string
            style?(titleLabel)
        case .currency(let currency, let currencyStyle):
            currencyStyle((currency.amount, currency.currencyCode))(titleLabel)
        }
        
        switch rowItem.subTitle {
        case .text(let string, let style):
            subtitleLabel.text = string
            style?(subtitleLabel)
        case .currency(let currency, let currencyStyle):
            currencyStyle((currency.amount, currency.currencyCode))(subtitleLabel)
        }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
