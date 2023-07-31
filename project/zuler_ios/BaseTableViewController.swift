//
//  BaseTableViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/18.
//

import UIKit
import Alamofire
import MJRefresh
import SwiftyJSON

class BaseTableViewController: BaseViewController {
    
    var isHeaderRefresh = true
    var isHaveToken = false
    var page = 1
    var pageSize = 20
    var emptyMessage = ""
    var emptyBtnTitle = ""
    var emptyImgName = ""
    var isShowEmptyBtn = false
    var emptyShouldDisplay = true
    var headerLoadingColor = UIColor.gray
    
    var refreshType: TVloadType = .none {
        didSet {
            switch refreshType {
            case .refresh:
                self.setRefreshHeader()
            case .more:
                self.setRefreshFooter()
            case .all:
                self.setRefreshHeader()
                self.setRefreshFooter()
            default:
                break
            }
        }
    }

    var requestURL = ""
    var requestParams: [String: Any] = [:]
    var requestMethod = HTTPMethod.get
    var isPage = true // 是否分页
    var isShowFooterMessage = false //是否展示footer提示信息
    var footerMessage = "— 没有更多了 —"
    var dataList = [Any]()
    private var hideRefreshFooter = false
    private var responseListDataModel: BaseResponseListDataModel?
    var isResponsed = false//是否已经请求完毕
    
    open var responseNoDataType = ResponseNoDataType.none
    var tableViewStyle = UITableView.Style.plain
    lazy var baseTableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: self.tableViewStyle)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.separatorInset = UIEdgeInsets.zero
        table.backgroundColor = UIColor.hex_FFFFFF
        table.showsVerticalScrollIndicator = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        prepareTableView()
    }

    // MARK: - ui

    public func prepareTableView() {
        baseTableView.frame = view.bounds
        view.addSubview(baseTableView)
    }

    private func setRefreshHeader() {
    
        let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        header.loadingView?.color = headerLoadingColor
        header.arrowView?.image = UIImage(named: "")
        header.stateLabel?.isHidden = true
        header.lastUpdatedTimeLabel?.isHidden = true
        baseTableView.mj_header = header
        
    }

    private func setRefreshFooter() {
        
        let footer = MJRefreshBackGifFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        baseTableView.mj_footer = footer
        footer.isHidden = true
    }
    

    func endRefresh(footerState: Int) {
        baseTableView.mj_header?.endRefreshing()
        if footerState == 0 {
            // 隐藏footer
            hideRefreshFooter = true
            baseTableView.mj_footer?.isHidden = true
        } else if footerState == 1 {
            hideRefreshFooter = false
            baseTableView.mj_footer?.isHidden = false
            baseTableView.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            hideRefreshFooter = false
            baseTableView.mj_footer?.isHidden = false
            baseTableView.mj_footer?.endRefreshing()
        }
    }

    // MARK: - event

    @objc func headerRefresh() {
        isHeaderRefresh = true
        pullDownRequest()
    }

    @objc func footerRefresh() {
        isHeaderRefresh = false
        pullUpRequest()
    }

    // MARK: - request
    
    public func requestList() {
        if (refreshType == .all || refreshType == .more) && isHeaderRefresh == false {

            if responseListDataModel?.hasMore == true && responseListDataModel?.next != nil {
                requestParams["lastItem"] = responseListDataModel?.next ?? ""
            }
            
        }else {
            requestParams.removeValue(forKey: "lastItem")
        }
        
        requestParams["count"] = "\(pageSize)"
        requestParams["limit"] = "\(pageSize)"
        
        NetManager.manager.request(method: requestMethod, url: requestURL, params: requestParams) {[weak self] (response) in
            
//            self?.responseListDataModel = BaseResponseListDataModel.deserialize(from: response?.data)
//            let list = self?.parseResponseData(with: response?.data)
//            if self?.isHeaderRefresh == true {
//                self?.dataList = list ?? []
//            }else {
//                self?.dataList += list ?? []
//            }
//            if self?.responseListDataModel?.hasMore == true {
//                self?.endRefresh(footerState: 2)
//            }else {
//                self?.endRefresh(footerState: 0)
//            }
//            
//            if list?.count == 0 {
//                self?.hideRefreshFooter = false
//            }
//            
//            self?.responseNoDataType = .normal
//            self?.isResponsed = true
//            self?.baseTableView.reloadData()
            
        } failure: { (error) in
                
            if NetworkReachabilityManager.default!.isReachable {
                self.responseNoDataType = .serverError
            } else {
                self.responseNoDataType = .networkDisable
            }
            self.isResponsed = true
            self.requestResponseFailed()
            self.endRefresh(footerState: 0)
            self.hideRefreshFooter = false
            self.baseTableView.reloadData()
        }
    }

    public func parseResponseData(with resonse: [String: Any]?) -> [Any] {
        return []
    }
    
    
    /// 请求失败（子控制器自定义时使用）
    public func requestResponseFailed() {
        
    }

    private func pullDownRequest() {
        requestList()
    }

    private func pullUpRequest() {
        requestList()
    }
    
    private func openLocationAction() {
        
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func serverErrorEmptyAction() {
        requestList()
    }
    
    func customEmptyAction() {
        
    }
    
    @objc private func emptyBtnAction() {

        switch self.responseNoDataType {
        case .networkDisable:
            openLocationAction()
        case .serverError:
            serverErrorEmptyAction()
        default:
            customEmptyAction()
        }
    }
}

extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if isShowFooterMessage && hideRefreshFooter {
            return 90
        }
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.hex_FFFFFF
        return v
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        if isShowFooterMessage && hideRefreshFooter {

            let v = UIView()
            let lb = UILabel()
            lb.text = footerMessage
            lb.textAlignment = .center
            lb.font = UIFont.systemFont(ofSize: 12)
            lb.textColor = UIColor.hex_999999
            v.addSubview(lb)
            lb.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(25)
            }
            return v
        }
        let v = UIView()
        v.isUserInteractionEnabled = true
        v.backgroundColor = UIColor.hex_FFFFFF
        return v
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension BaseTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return (emptyShouldDisplay && isResponsed)
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let v = BaseEmptyView.init(frame: CGRect(x: 0, y: 0, width: SRNW, height: SRNH))
        var str = ""
        var img = ""
        var btnTitle = ""
        switch responseNoDataType {
        case .normal:
            if emptyMessage.count == 0 {
                str = "这里好空，什么都没有"
            }else{
                str = emptyMessage
                btnTitle = emptyBtnTitle
            }
            img = "img_kong"
        case .serverError:
            str = "前方拥堵，休息一下"
            img = "img_failed"
            btnTitle = "点击刷新"
            isShowEmptyBtn = true
        case .networkDisable:
            str = "你好像开到了外太空，失去了网络"
            img = "img_nonet"
            btnTitle = "打开网络"
            isShowEmptyBtn = true
        default:
            str = emptyMessage
            img = emptyImgName
            btnTitle = emptyBtnTitle
        }
        
        v.emptyLabel.text = str
        v.emptyImgView.image = UIImage(named: img)
        v.emptyBtn.isHidden = !isShowEmptyBtn
        if isShowEmptyBtn {
            v.emptyBtn.setTitle(btnTitle, for: .normal)
            v.emptyBtn.addTarget(self, action: #selector(emptyBtnAction), for: .touchUpInside)
        }
        return v
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {

        return SRNW/2.0
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        PrintLog("tap")
    }
}
