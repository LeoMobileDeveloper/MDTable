//
//  SwipteToDeleteController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class ReorderRow: Row, EdiRowConvertable{
    var titleForDeleteConfirmationButton: String? = nil
    var editingStyle:UITableViewCellEditingStyle = .none
    var canMove: Bool = true
    var shouldIndentWhileEditing: Bool = false
}

class ReorderTableViewController: UITableViewController {
    var tableManager:TableManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = false
        navigationItem.title = "Reorder"
        tableView.setEditing(true, animated: false)
        let rows = (1..<100).map { (index) -> ReorderRow in
            let row = ReorderRow(title: "\(index)")
            return row
        }
        let section = Section(rows: rows)
        section.heightForHeader = 0.0
        let tableEditor = SystemTableEditor()
        tableEditor.moveRowAtSourceIndexPathToDestinationIndexPath = {(tableView,sourceIndexPath,destinationIndexPath) in
            tableView.manager?.exchange(sourceIndexPath, with: destinationIndexPath)
        }
        tableView.manager = TableManager(sections: [section],editor:tableEditor)
    }
}

