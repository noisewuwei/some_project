//
//  TestViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/17.
//

import UIKit

protocol testDelegate: NSObjectProtocol {
    func testFunc(_ str: String) -> Void
}

class TestViewController: BaseViewController {
    
    var testCallBack: ((String) -> Void)?
    
    var label : UILabel?
    
    weak var delegate: testDelegate?

//    修改状态栏颜色 有需要的话 可以使用
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "测试页面"
        
        self.view.backgroundColor = .yellow

        let view = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        view.backgroundColor = .black
        self.view.addSubview(view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(test(tap:)))
        
        view.addGestureRecognizer(tap)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragMoving(pan:))))
        
        label = UILabel()
        label?.textColor = .black
        label?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.view.addSubview(label!)
        
        label?.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }

        
//        self.setNavLeftItemWithTitleAndImg("", withImgName: "cha")
        
        // Do any additional setup after loading the view.
    }
    
    // pan手势事件
    
    @objc func dragMoving(pan: UIPanGestureRecognizer){
        
        let point = pan.translation(in: view)
        
        if pan.state == .began {
            
            pan.view?.alpha = 0.8
            
        }
        
        pan.view?.center = CGPoint(x: pan.view!.center.x + point.x, y: pan.view!.center.y + point.y)
        
        pan.setTranslation(.zero, in: view)
        
        PrintLog(pan.view?.center)//获取中心坐标 之后会需要计算时图的映射坐标 通过长链接传给server
        
        label?.text = "\(pan.view?.center)"
        
    }
    
    @objc func test(tap: UITapGestureRecognizer){
        
//        if let callBack = self.testCallBack {
//            callBack("test")
//        }
        
        guard let _ = delegate else {
            return
        }
        
        delegate?.testFunc("xixi")
        
        self.navigationController?.popViewController(animated: true)
        
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



// 拖拽结束后 可以让视图靠边停留
//if pan.state == .ended {
//
//    if let v = pan.view{
//
//        let top = v.frame.minY ; let left = v.frame.minX ; v.alpha = 1
//
//        let bottom = view.frame.height - v.frame.maxY - 49
//
//        let right = SRNW - v.frame.maxX
//
//        let temp = [top,left,bottom,right].sorted().first
//
//        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//
//            if temp == top{
//
//                v.transform = v.transform.translatedBy(x: 0, y: -top)
//
//            }else if temp == left{
//
//                v.transform = v.transform.translatedBy(x: -left, y: 0)
//
//            }else if temp == bottom{
//
//                v.transform = v.transform.translatedBy(x: 0, y: bottom)
//
//            }else{
//
//                v.transform = v.transform.translatedBy(x: right, y: 0)
//
//            }
//
//        }, completion: { (finish) in
//
//        })
//
//    }
//
//}
