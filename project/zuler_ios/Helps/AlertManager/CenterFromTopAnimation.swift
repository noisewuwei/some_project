//
//  CenterFromTopAnimation.swift
//  WXZGame
//
//  Created by HyBoard on 2020/8/25.
//  Copyright © 2020 HyBoard. All rights reserved.
//

import UIKit

class CenterFromTopAnimation: BaseAnimation {

    private let duration = 0.55
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        
        let isPresenting = (fromVC == self.presentingViewController)
        
        
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
            let x = (SRNW-toViewSize.width)/2.0
            let y = -1*SRNH
            let beginFrame = CGRect(x: x, y: y, width: toViewSize.width, height: toViewSize.height)
            let showFrame = CGRect(x: x, y: (SRNH-toViewSize.height)/2.0, width: toViewSize.width, height: toViewSize.height)
            
            let containerView = transitionContext.containerView
            toView?.frame = beginFrame
            containerView.addSubview(toView!)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                toView?.frame = showFrame
            }) { (finish) in
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
            
            let toViewSize = alertVC.alertViewSize()
            let x = (SRNW-toViewSize.width)/2.0
            let y = SRNH
            let endFrame = CGRect(x: x, y: y, width: toViewSize.width, height: toViewSize.height)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                
                fromView?.frame = endFrame
            }) { (finish) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
}
