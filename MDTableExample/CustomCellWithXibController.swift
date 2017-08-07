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
        let rows = (1..<100).map { (index) -> XibRow  in
            let row = XibRow(title: "Title\(index)", subTitle: "Subtitle \(index)", image: UIImage(named: "avatar"))
            row.onDidSelected({ (tableView, indexPath) in
                tableView.manager?.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            return row
        }
        let section = Section(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableView.manager = TableManager(sections: [section])
    }
}

