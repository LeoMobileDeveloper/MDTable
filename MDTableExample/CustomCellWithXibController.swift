//
//  CustomCellWithXibController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class CustomCellWithXibController: UITableViewController {
    var tableManager:TableManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Custom cell with XIB"
        let rows = (1..<100).map { (index) -> CustomXibRow  in
            let row = CustomXibRow(title: "Title\(index)", subTitle: "Subtitle \(index)", image: UIImage(named: "avatar")!)
            row.didSelectRowAt = { [unowned self] (tableView, indexPath) in
                self.tableManager.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return row
        }
        let section = SystemSection(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableManager = TableManager(sections: [section])
        tableView.md_bindTo(manager: tableManager)
    }
}

