//
//  TestTableViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/18.
//

import UIKit

class TestTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isPage = false //true
        requestParams = ["":""]
//        requestURL = ApiManager.verificationVersion
//        requestList()

        // Do any additional setup after loading the view.
    }
    
    override func prepareTableView() {
        super.prepareTableView()
        
        isShowEmptyBtn = true
        emptyBtnTitle = "test"
        emptyMessage = "(ಥ_ಥ)"
        
        self.baseTableView.frame = CGRect.init(x: 0, y: 0, width: SRNW, height: SRNH)
        self.baseTableView.backgroundColor = UIColor.hex_F7F7F7
        baseTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        baseTableView.rowHeight = UITableView.automaticDimension
        self.refreshType = .refresh //all
        baseTableView.estimatedRowHeight = 200
//        baseTableView.register(MyOrderTableViewCell.self, forCellReuseIdentifier: "MyOrderTableViewCell")
        baseTableView.showsVerticalScrollIndicator = false
    }
    
    override func customEmptyAction() {
        //no data action
    }
    
    override func parseResponseData(with resonse: [String : Any]?) -> [Any] {
//        let model = model.deserialize(from: resonse)
//        return model?.blocks ?? []
        
        return []
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
