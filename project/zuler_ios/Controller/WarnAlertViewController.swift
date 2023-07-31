//
//  WarnAlertViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit

class WarnAlertViewController: BaseAlertViewController {

    var warnType: WarnAlertType = .cancelPublish
    var showCancel: Bool = true
    var cancelActionCallback: (() -> Void)?
    var confirmActionCallback: (() -> Void)?
    lazy var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex_FFFFFF
        v.layer.cornerRadius = 6
        return v
    }()
    
    lazy var titleLb: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.hex_181818
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    lazy var contentLb: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.hex_181818
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.numberOfLines = 0
        return lb
    }()
    
    lazy var vLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex_F2F1F0
        return v
    }()
    
    lazy var hLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.hex_F2F1F0
        return v
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.hex_999999, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(closeBtnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(UIColor.hex_181818, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSubViews()
    }
    
    func setSubViews() {
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(135)
        }
        
        titleLb.isHidden = true
        bgView.addSubview(titleLb)
        titleLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        
        bgView.addSubview(contentLb)
        contentLb.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.centerY.equalTo(45)
        }
        
        bgView.addSubview(hLineView)
        hLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-45)
            make.height.equalTo(1)
        }
        
        if showCancel {
            bgView.addSubview(vLineView)
            vLineView.snp.makeConstraints { (make) in
                make.bottom.centerX.equalToSuperview()
                make.width.equalTo(1)
                make.top.equalTo(hLineView.snp.bottom)
            }
            
            bgView.addSubview(cancelBtn)
            cancelBtn.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.top.equalTo(hLineView.snp.bottom)
                make.right.equalTo(vLineView.snp.left)
            }
            
            bgView.addSubview(confirmBtn)
            confirmBtn.snp.makeConstraints { (make) in
                make.right.bottom.equalToSuperview()
                make.top.equalTo(hLineView.snp.bottom)
                make.left.equalTo(vLineView.snp.right)
            }
        }else{
            bgView.addSubview(confirmBtn)
            confirmBtn.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(hLineView.snp.bottom)
            }
        }
        
        switch warnType {
        case .cancelPublish:
            titleLb.text = "取消发布"
            contentLb.text = "是否将此次编辑保留？"
            cancelBtn.setTitle("不保留", for: .normal)
            confirmBtn.setTitle("保留", for: .normal)

        case .logout:
            
            titleLb.text = "退出登录"
            contentLb.text = "是否确定退出登录？"
            cancelBtn.setTitle("取消", for: .normal)
            confirmBtn.setTitle("确定", for: .normal)
            
        case .deleteVideo:
            titleLb.text = "删除"
            contentLb.text = "删除这段视频吗？"
            cancelBtn.setTitle("取消", for: .normal)
            confirmBtn.setTitle("确定", for: .normal)
            
        case .loginError:
            titleLb.text = ""
            contentLb.text = "当前手机号已绑定第三方账号，是否解绑旧账号并绑定当前账号？"
            cancelBtn.setTitle("取消", for: .normal)
            confirmBtn.setTitle("确认", for: .normal)
        case .checkPayment:
            titleLb.text = ""
            contentLb.text = "请等待订单支付结果确认，勿重复支付"
            cancelBtn.setTitle("未完成支付", for: .normal)
            confirmBtn.setTitle("已完成支付", for: .normal)
            
        case .editInfo:
            titleLb.text = ""
            contentLb.text = "信息有变更，是否需要保存？"
            cancelBtn.setTitle("不保存", for: .normal)
            confirmBtn.setTitle("保存", for: .normal)
            
        case .joinBlacklist:
            titleLb.text = ""
            contentLb.text = "加入黑名单后，TA不能给你的随想打闪，评论，无法看到你的个人主页"
            cancelBtn.setTitle("取消", for: .normal)
            confirmBtn.setTitle("确认", for: .normal)
            
        }
    }

    @objc func closeBtnAction() {
        
        dismiss(animated: true) {
            if let callback = self.cancelActionCallback {
                callback()
            }
        }
    }
    
    @objc func confirmBtnAction() {
        
        dismiss(animated: true) {
            if let callback = self.confirmActionCallback {
                callback()
            }
        }
    }

    override func alertViewSize() -> CGSize {
        return CGSize(width: 300, height: 135)
    }
}
