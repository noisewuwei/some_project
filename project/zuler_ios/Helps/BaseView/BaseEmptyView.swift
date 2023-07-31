//
//  BaseEmptyView.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/18.
//

import UIKit

class BaseEmptyView: UIView {
    
    lazy var emptyImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "img_kong")
        return iv
    }()
    
    lazy var emptyLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = UIColor.hex_737373
        lb.text = "这里好空，什么都没有"
        lb.textAlignment = .center
        return lb
    }()
    
    lazy var emptyBtn: UIButton = {
        
        let btn = UIButton()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyImgView)
        emptyImgView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.width.height.equalTo(160)
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyImgView.snp.bottom).offset(20)
        }
        
        addSubview(emptyBtn)
        emptyBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(144)
            make.height.equalTo(44)
            make.top.equalTo(emptyLabel.snp.bottom).offset(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
