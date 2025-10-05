//
//  Created by Backbase on 31/01/2024.
//

import UIKit
import BackbaseDesignSystem

final class DemoViewController: UIViewController {

    init(title: String) {
        super.init(nibName: nil, bundle: .main)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let stateView = getStateView()
        stateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stateView)
       
        NSLayoutConstraint.activate([
            stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stateView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        view.backgroundColor = Theme.colors.background.surface1

    }

    private func getStateView() -> StateView {
        let config = GenericStateViewConfiguration(iconName: DesignSystem.Assets.icStateViewLoadingFailed,
                                                   title: Bundle.main.localize("demoViewController.stateViewTitle") ?? "",
                                                   subtitle: Bundle.main.localize("demoViewController.stateViewSubtitle") ?? "",
                                                   animationView: nil,
                                                   firstButtonConfiguration: nil,
                                                   secondButtonConfiguration: nil,
                                                   thirdButtonConfiguration: nil)
        let params = StateViewInitParams(configuration: config, bundles: .main)
        return StateView(params: params)
    }
}
