//
//  SystemCellController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class SystemCellController: UIViewController {
    var tableManager:TableManager!
    var customSwitchValue = true
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "System cell"
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        
        let section0 = buildSection0()
        tableView.manager = TableManager(sections: [section0])
    }
    
    func buildSection0()->Section{
        
        let row0 = Row(title: "Basic", rowHeight: 40.0, accessoryType: .none)
        
        let row1 = Row(title: "Custom Color", rowHeight: 40.0, accessoryType: .detailDisclosureButton)
        row1.onRender { (cell,isInital) in
            cell.textLabel?.textColor = UIColor.orange
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }.onDidSelected { (tableView, indexPath) in
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        let row2 = Row(title: "Title",
                             image: UIImage(named: "avatar"),
                             detailTitle: "Detail Title",
                             rowHeight: 60.0,
                             accessoryType: .disclosureIndicator);
        row2.cellStyle = .value1
        
        let row3 = Row(title: "Title",
                             image: UIImage(named: "avatar"),
                             detailTitle: "Sub Title",
                             rowHeight: 60.0,
                             accessoryType: .checkmark);
        row3.cellStyle = .subtitle
        
        let row4 = Row(title: "Title",
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
        let section = Section(rows: [row0,row1,row2,row3,row4])
        section.heightForHeader = 10.0
        section.heightForFooter = 0.0
        return section
    }
}
