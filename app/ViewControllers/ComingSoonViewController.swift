//
//  Created by Backbase on 31/01/2024.
//

import UIKit
import BackbaseDesignSystem

final class ComingSoonViewController: UIViewController {
    static func build(title: String) -> (UINavigationController) -> UIViewController {
        { _ in
            let comingSoonController = ComingSoonViewController(title: title)
            comingSoonController.view.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
            comingSoonController.tabBarItem.image = UIImage(systemName: "pencil.and.scribble")
            return comingSoonController
        }
    }

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
        stateView.snp.makeConstraints { make in
            make.trailing.leading.centerY.equalToSuperview()
        }
    }

    private func getStateView() -> StateView {
        let config = GenericStateViewConfiguration(iconName: DesignSystem.Assets.icStateViewLoadingFailed,
                                                   title: Bundle.main.localize("comingSoonViewController.stateViewTitle") ?? "",
                                                   subtitle: Bundle.main.localize("comingSoonViewController.stateViewSubtitle") ?? "",
                                                   animationView: nil,
                                                   firstButtonConfiguration: nil,
                                                   secondButtonConfiguration: nil)
        let params = StateViewInitParams(configuration: config, bundles: .main)
        return StateView(params: params)
    }
}
