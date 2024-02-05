//
//  Created by Backbase on 31/01/2024.
//

import UIKit
import BackbaseDesignSystem

final class ComingSoonViewController: UIViewController {

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
        let config = GenericStateViewConfiguration(iconName: "ic_state_view_loading_failed",
                                                   title: "Journey under construction!",
                                                   subtitle: "Soon a new journey will be added to this tab. Stay tuned!",
                                                   animationView: nil,
                                                   firstButtonConfiguration: nil,
                                                   secondButtonConfiguration: nil)
        let params = StateViewInitParams(configuration: config, bundles: .main)
        return StateView(params: params)
    }
}
