//
//  BaseViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: QMUICommonViewController {
    
    open lazy var bag = DisposeBag()
    
    open lazy var leftBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        btn.addTarget(self, action: #selector(leftButtonAction(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        return btn
    }()

    open lazy var rightBtn:UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitleColor(UIColor.hex_181818, for: .normal)
        btn.setTitleColor(UIColor.hex_999999, for: .disabled)
        btn.contentHorizontalAlignment = .right
        btn.frame = CGRect.init(x: 0, y: 2.5, width: 60, height: 25)
        btn.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        v.addSubview(btn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: v)
        
        return btn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setNavBarBackgroundColor(.white)
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        setDefaultBackItem()
        
        // Do any additional setup after loading the view.
    }
    
    func setNavBarBackgroundColor(_ bgColor : UIColor) {
        let barImg = UIImage.imageWithColor(bgColor)
        self.navigationController?.navigationBar.setBackgroundImage(barImg, for: .any, barMetrics: .default)

    }

    override func shouldCustomizeNavigationBarTransitionIfHideable() -> Bool {
        return true
    }
    
    override func forceEnableInteractivePopGestureRecognizer() -> Bool {
        return true
    }
    
    
    public func setDefaultBackItem() -> Void {
        if self.navigationController?.viewControllers.count ?? 1 > 1 {
            self.setNavLeftItemWithTitleAndImg("", withImgName: "back")
        }
        self.setupNavigationItems()
    }

    //  MARK: - 设置左边按钮的标题，图片
    /// 设置左边按钮的标题，图片
    func setNavLeftItemWithTitleAndImg(_ title:String,withImgName name:String) -> Void {

        self.leftBtn.setTitle(title, for: .normal)
        self.leftBtn.setImage(UIImage(named: name), for: .normal)
    }
    
    
    @objc func leftButtonAction(_ btn:UIButton) -> Void {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 右边按钮事件
    /// 右边按钮事件
    @objc func rightButtonAction(_ btn:UIButton) -> Void {
        
    }
    
    
    // 隐藏导航栏
    //    override func preferredNavigationBarHidden() -> Bool {
    //        return true
    //    }
    //
    //    override func navigationBarBarTintColor() -> UIColor? {
    //        return UIColor.hex_FFFFFF
    //    }
    //
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
