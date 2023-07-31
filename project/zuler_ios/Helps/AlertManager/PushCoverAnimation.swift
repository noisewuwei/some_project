//
//  PushCoverAnimation.swift
//  LappTest
//
//  Created by 张嘉迁 on 2020/12/3.
//

import UIKit

class PushCoverAnimation: BaseAnimation {

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)
        let isPresenting = (fromVC == self.presentingViewController)
        
        if isPresenting {
            
            let toView = transitionContext.view(forKey: .to)
            let containerView = transitionContext.containerView
            toView?.frame = CGRect(x: SRNW, y: 0, width: SRNW, height:SRNH)
            containerView.addSubview(toView!)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                
                toView?.frame = CGRect(x: 0, y: 0, width: SRNW, height: SRNH)
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

            
        }else {
            guard let fromView = fromVC?.view else { return }
            fromView.frame = CGRect(x: 0, y: 0, width: SRNW, height: SRNH)
            UIView.animate(withDuration: transitionDuration(using: transitionContext)) {
                
                fromView.frame = CGRect(x: SRNW, y: 0, width: SRNW, height: SRNH)
            } completion: { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    
}
