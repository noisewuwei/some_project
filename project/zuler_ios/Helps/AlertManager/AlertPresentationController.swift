//
//  AlertPresentationController.swift
//  AlertTest
//
//  Created by HyBoard on 2020/8/20.
//  Copyright © 2020 HyBoard. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController {

    var animation: BaseAnimation?
    lazy var backgrounView: UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor.hex_181818.withAlphaComponent(0.3)
        view.alpha = 0
        return view
    }()
    var bgViewUserInteractionEnabled: Bool = true {
        didSet {
            self.backgrounView.isUserInteractionEnabled = bgViewUserInteractionEnabled
        }
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.backgrounView.frame = self.containerView!.bounds
    }
   
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        let vc = container as! UIViewController
        if vc == presentedViewController {
            return vc.preferredContentSize
        }else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        let vc = container as! UIViewController
        if vc == presentedViewController {
            self.containerView?.setNeedsLayout()
        }
    }
    
    
    override func presentationTransitionWillBegin() {
        self.backgrounView.frame = self.containerView!.bounds
        backgrounView.addTarget(self, action: #selector(dismissAction(_ :)), for: .touchUpInside)
        self.containerView?.addSubview(backgrounView)
        backgroundViewAnimation(animationIn: true)
    }
    
    override open func dismissalTransitionWillBegin() {
        backgroundViewAnimation(animationIn: false)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            backgrounView.removeFromSuperview()
        }
    }
    
    private func backgroundViewAnimation(animationIn: Bool) {
        let alpha: CGFloat = animationIn ? 1 : 0
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.backgrounView.alpha = alpha
            }, completion: nil)
        }
    }
    
    @objc func dismissAction(_ sender: UIButton) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
}

extension AlertPresentationController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animation?.presentingViewController = self.presentingViewController
        return animation
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animation?.presentingViewController = self.presentingViewController
        return animation
    }
}


