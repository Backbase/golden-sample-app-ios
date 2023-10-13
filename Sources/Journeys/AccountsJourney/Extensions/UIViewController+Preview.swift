//
//  UIViewController+Preview.swift
//  GoldenSampleApp
//
//  Created by George Nyakundi on 13/10/2023.
//

#if DEBUG
import UIKit
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // use this to inject the current viewController
        let vc: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return vc
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
    
    func toPreview() -> some View {
        // inject self (the current view controller) to the preview
        Preview(vc: self)
    }
}

#endif
