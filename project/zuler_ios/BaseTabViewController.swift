//
//  BaseTabViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit

class BaseTabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        do {
            try
                AVAudioSession.sharedInstance().setCategory(.ambient)
        }catch{
        }
        
        self.tabBar.tintColor = UIColor.hex_F0AA79
        self.tabBar.isTranslucent = false
        UITabBar.appearance().backgroundImage = UIImage.imageWithColor(UIColor.hex_000000)
        
        for (index,item) in getTabBarItems().enumerated() {
            
            guard let dic = (item as? NSDictionary) else {
                return
            }
            
            let title: String = "\(dic["title"] ?? "")"
            let selectedImage: String = "\(dic["selectedImage"] ?? "")"
            let normalImage: String = "\(dic["normalImage"] ?? "")"
            let controller: String = "\(dic["controller"] ?? "")"
            
            var string_vc = vcString_to_viewController(controller)
    
            guard let vc = string_vc else {
                return
            }
            
            let nav = BaseNavigationViewController.init(rootViewController: vc)
            
            let barItem = UITabBarItem.init(title: title, image: UIImage.imgWithName(normalImage)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.imgWithName(selectedImage)?.withRenderingMode(.alwaysOriginal))
            //设置正常和选中的颜色
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.hexColor("#999999"), NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11)], for: .normal)
            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.hex_F0AA79, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 11)], for: .selected)
            
            vc.title = title
            vc.tabBarItem = barItem
            
            
            self.addChild(nav)
            
        }

        // Do any additional setup after loading the view.
    }
    
    func getTabBarItems() -> NSMutableArray {
        var result = NSArray()
        let resultDic = getJsonDataWith("BaseTabBarItem")
        if let menuItems:NSArray = resultDic["tabBarItems"] as? NSArray
        {
            result = menuItems
        }
        
        return NSMutableArray.init(array: result)
    }
    
    func getJsonDataWith(_ jsonFile: String) -> NSDictionary {
        
        let path = Bundle.main.path(forResource: jsonFile, ofType: "json")
        var result = NSDictionary()
        
        guard let _ = path else {
            return result
        }
        
        if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
            do{
                if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                {
                    result = jsonObj
                    
                }
            } catch{
    //            PrintLog("error --> \(path ?? "")")
            }
        }
        return result
    }

    func vcString_to_viewController(_ childControllerName: String) -> UIViewController? {
        
        // 1.获取命名空间
        // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的值的类型为AnyObject?
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            return nil
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            //            PrintLog("无法转换成UIViewController")
            return nil
        }
        // 3.通过Class创建对象
        let childController = clsType.init()
        
        return childController
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
