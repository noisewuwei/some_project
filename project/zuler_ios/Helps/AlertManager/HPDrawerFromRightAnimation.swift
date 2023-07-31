//
//  DrawerFromRightAnimation.swift
//  LappTest
//
//  Created by 张嘉迁 on 2020/12/16.
//

import UIKit

class HPDrawerFromRightAnimation: BaseAnimation {

    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let isPresenting = (fromVC == self.presentingViewController)
        let size = UIScreen.main.bounds.size

        if isPresenting {
            
            var alertVC: BaseAlertViewController!
            let toVC = transitionContext.viewController(forKey: .to)
            if toVC is UINavigationController {
                let nav = toVC as! UINavigationController
                alertVC = nav.topViewController as? BaseAlertViewController
            }else {
                alertVC = toVC as? BaseAlertViewController
            }
            
            let toView = transitionContext.view(forKey: .to)
            let toViewSize = alertVC.alertViewSize()
            
            let showFrame = CGRect(x: size.width-210, y: 0, width: 210, height: size.height)
            let hiddenFrame = CGRect(x: size.width, y: 0, width: 210, height: size.height)
            
            let containerView = transitionContext.containerView
            toView?.frame = hiddenFrame
            containerView.addSubview(toView!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                
                toView?.frame = showFrame
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

            
        }else {
            
            let fromView = transitionContext.view(forKey: .from)
            var alertVC: BaseAlertViewController!
            if fromVC is UINavigationController {
                let nav = fromVC as! UINavigationController
                alertVC = nav.topViewController as? BaseAlertViewController
            }else {
                alertVC = fromVC as? BaseAlertViewController
            }
            
            let fromViewSize = alertVC.alertViewSize()
            let hiddenFrame = CGRect(x: size.width, y: 0, width: 210, height: size.height)
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                
                fromView?.frame = hiddenFrame
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
