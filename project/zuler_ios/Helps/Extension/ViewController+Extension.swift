//
//  ViewController+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit



extension UIViewController {
    func initAlert(extitle title : String , msg message : String,_ style : UIAlertController.Style = .alert , sureComplate complate: @escaping ()->()) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: style)
        let action1 = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        alert.addAction(action1)
        let action2 = UIAlertAction(title: "确定", style: .default) { (action) in
            complate()
        }
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    /**
     *  push 到下一个控制器
     */
    func pushTo(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    /**
     *  present 到下一个控制器
     */
    func presentTo(_ viewController: UIViewController)
    {
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true) {
            // 跳转
        }
    }
    /**
     *  从当前控制器 pop
     */
    func popViewController(_ animated:Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
   
    /**
     *  当前控制器 dismiss
     */
    func dismiss() {
        self.dismiss(animated: true) {
            
        }
    }
}


