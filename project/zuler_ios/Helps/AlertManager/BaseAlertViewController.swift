//
//  BaseAlertViewController.swift
//  WXZGame
//
//  Created by HyBoard on 2020/8/25.
//  Copyright © 2020 HyBoard. All rights reserved.
//

import UIKit


class BaseAlertViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.hex_FFFFFF.withAlphaComponent(0)
    }
    
    /// 继承自该类的VC   必须重写该方法  否则会有响应的问题
    /// 这里设置的是弹框的大小
    public func alertViewSize() -> CGSize {
        return CGSize.zero
    }
    
    func getSafeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let area = view.safeAreaInsets
            return area
        } else {
            // Fallback on earlier versions
            return UIEdgeInsets.zero
        }
    }
}
