//
//  BaseNavigationViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/17.
//

import UIKit

class BaseNavigationViewController: QMUINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let vc = self.topViewController
        return vc!.preferredStatusBarStyle
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0{
            
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(back))
            
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc func back(){
        
        popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
