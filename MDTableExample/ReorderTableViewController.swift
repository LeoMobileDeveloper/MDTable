//
//  SwipteToDeleteController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class ReorderRow: SystemRow, EditableRow{
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
        let section = SystemSection(rows: rows)
        section.heightForHeader = 0.0
        let tableEditor = SystemTableEditor()
        tableEditor.moveRowAtSourceIndexPathToDestinationIndexPath = {  [unowned self] (tableview,sourceIndexPath,destinationIndexPath) in
            self.tableManager.exchange(sourceIndexPath, with: destinationIndexPath)
        }
        tableManager = TableManager(sections: [section],editor:tableEditor)
        tableView.md_bindTo(manager: tableManager)
    }
}

