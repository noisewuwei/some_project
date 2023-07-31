//
//  BottomAnimation.swift
//  WXZGame
//
//  Created by HyBoard on 2020/9/1.
//  Copyright © 2020 HyBoard. All rights reserved.
//

import UIKit

class BottomAnimation: BaseAnimation {
    
    
    private let duration = 0.55
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        
        let isPresenting = (fromVC == self.presentingViewController)
        
        
        if isPresenting {
            
            let toVC = transitionContext.viewController(forKey: .to) as! BaseAlertViewController
            let toView = transitionContext.view(forKey: .to)
            let toViewSize = toVC.alertViewSize()
            
            let showFrame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-toViewSize.height, width: toViewSize.width, height: toViewSize.height)
            let hiddenFrame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: toViewSize.width, height: toViewSize.height)

            let containerView = transitionContext.containerView
            toView?.frame = hiddenFrame
            containerView.addSubview(toView!)
            

            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
                toView?.frame = showFrame
            }) { (finish) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        }else {
            
            let fromView = transitionContext.view(forKey: .from)
            let tempFromVC = fromVC as! BaseAlertViewController
            let fromViewSize = tempFromVC.alertViewSize()
            let hiddenFrame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: fromViewSize.width, height: fromViewSize.height)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                
                fromView?.frame = hiddenFrame
            }) { (finish) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
}
