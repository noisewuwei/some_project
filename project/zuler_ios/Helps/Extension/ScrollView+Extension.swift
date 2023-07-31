//
//  ScrollView+Extension.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2019/1/2.
//  Copyright © 2019 HyBoard. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    /**
     *  注册 cell
     */
    func registerFrom(_ cellClass: AnyClass) {
        
        self.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass.self))
    }
    /**
     *  注册 header
     */
    func registerHeaderFrom(_ cellClass: AnyClass) {
        
        self.register(cellClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(cellClass.self))
    }
    /**
     *  注册 Footer
     */
    func registerFooterFrom(_ cellClass: AnyClass) {
        
        self.register(cellClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NSStringFromClass(cellClass.self))
    }
}

extension UITableView {
    /* 正在播放的 cell */
    
//    var playingCell:InfoTableViewCell =
    
    func registerFrom(_ cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass.self))
    }
    func dequeueReusableCellFrom(_ cellClass: AnyClass) -> UITableViewCell? {
        let cell = self.dequeueReusableCell(withIdentifier: NSStringFromClass(cellClass.self))
        return cell
    }
    
}

extension UITableViewCell {
    func ad() {
//        self.
    }
}
