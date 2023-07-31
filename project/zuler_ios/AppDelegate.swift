//
//  AppDelegate.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = BaseTabViewController()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        return true
    }

    
    func getCurrentVC() -> UIViewController? {
        var currVC: UIViewController?
        var rootVC: UIViewController? = window?.rootViewController
        repeat {
            if rootVC is UINavigationController {
                let nav = rootVC as? UINavigationController
                let v: UIViewController? = nav?.viewControllers.last
                currVC = v
                rootVC = v?.presentedViewController
                continue
            } else if rootVC is UITabBarController {
                let tabVC = rootVC as? UITabBarController
                currVC = tabVC
                rootVC = tabVC?.viewControllers?[tabVC?.selectedIndex ?? 0]
                continue
            } else if rootVC != nil {
                currVC = rootVC
                break
            }
        } while rootVC != nil
        return currVC
    }

}

