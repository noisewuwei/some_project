//
//  UIViewController+Alert.swift
//  AlertTest
//
//  Created by HyBoard on 2020/8/20.
//  Copyright © 2020 HyBoard. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(_ viewControllerToPresent: UIViewController, animation: BaseAnimation = CenterScaleAnimation(), shouldDismissOnTouchOutside: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let vc = AlertPresentationController(presentedViewController: viewControllerToPresent, presenting: self)
            viewControllerToPresent.transitioningDelegate = vc
            vc.animation = animation
            vc.bgViewUserInteractionEnabled = shouldDismissOnTouchOutside
            self.present(viewControllerToPresent, animated: true, completion: completion)
        }
    }
    
    func coverPushViewController(_ viewController: UIViewController, animation: BaseAnimation = PushCoverAnimation()) {
        DispatchQueue.main.async {
            let vc = AlertPresentationController(presentedViewController: viewController, presenting: self)
            viewController.transitioningDelegate = vc
            vc.animation = animation
            vc.bgViewUserInteractionEnabled = false
            self.present(viewController, animated: true, completion: nil)
        }
    }
}
