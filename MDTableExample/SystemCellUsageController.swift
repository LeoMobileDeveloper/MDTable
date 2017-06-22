//
//  SystemCellController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class SystemCellUsageController: UIViewController {
    var tableManager:TableManager!
    var customSwitchValue = true
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "System cell"
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        
        let section0 = buildSection0()
        tableManager = TableManager(sections: [section0])
        tableView.md_bindTo(manager: tableManager)
    }
    
    func buildSection0()->SystemSection{
        
        let row0 = SystemRow(title: "Basic", rowHeight: 40.0, accessoryType: .none)
        
        let row1 = SystemRow(title: "Custom Color", rowHeight: 40.0, accessoryType: .detailDisclosureButton)
        row1.onRender { (cell,isInital) in
            cell.textLabel?.textColor = UIColor.orange
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }.onDidSelected { (tableView, indexPath) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let row2 = SystemRow(title: "Title",
                             image: UIImage(named: "avatar"),
                             detailTitle: "Detail Title",
                             rowHeight: 60.0,
                             accessoryType: .disclosureIndicator);
        row2.cellStyle = .value1
        
        let row3 = SystemRow(title: "Title",
                             image: UIImage(named: "avatar"),
                             detailTitle: "Sub Title",
                             rowHeight: 60.0,
                             accessoryType: .checkmark);
        row3.cellStyle = .subtitle
        
        let row4 = SystemRow(title: "Title",
                             image: UIImage(named: "avatar"),
                             detailTitle: "Sub Title",
                             rowHeight: 60.0,
                             accessoryType: .checkmark);
        row4.onRender { (cell,isInital) in
            if isInital{
                let customSwitch = UISwitch()
                cell.accessoryView = customSwitch
            }
        }
        row4.reuseIdentifier = "Cell With Switch"
        let section = SystemSection(rows: [row0,row1,row2,row3,row4])
        section.heightForHeader = 10.0
        section.heightForFooter = 0.0
        return section
    }
}
