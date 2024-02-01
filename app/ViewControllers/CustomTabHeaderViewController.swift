//
//  Created by Backbase on 31/01/2024.
//

import UIKit

final class CustomTabHeaderViewController: UIViewController {
    
    init(title: String) {
        super.init(nibName: nil, bundle: .main)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
