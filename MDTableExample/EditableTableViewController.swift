//
//  SwipteToDeleteController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class SwipteToDeleteRow: Row, EdiRowConvertable{
    var titleForDeleteConfirmationButton: String? = "Delete"
    var editingStyle:UITableViewCellEditingStyle = UITableViewCellEditingStyle.delete
}

class SwipteToDeleteController: UITableViewController {
    var tableManager:TableManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = true
        navigationItem.title = "Editable"
        reloadBarBarButton()
        
        let rows = (1..<100).map { (index) -> SwipteToDeleteRow in
            let row = SwipteToDeleteRow(title: "\(index)")
            return row
        }
        let section = Section(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Swipe to Delete"
        let tableEditor = SystemTableEditor()
        tableEditor.editingStyleCommitForRowAt = { (tableView, style, indexPath) in
            if style == .delete{
                tableView.manager?.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        tableView.manager = TableManager(sections: [section],editor:tableEditor)
    }
    
    @objc func handleEditing(_ sender:UIBarButtonItem){
        if tableView.isEditing{ //Delete rows selected
            guard let selectedRows = tableView.indexPathsForSelectedRows else{
                return
            }
            tableManager.delete(rows: Set(selectedRows))
            tableView.deleteRows(at: selectedRows, with: .top)
        }
        tableView.setEditing(!tableView.isEditing, animated: true)
        reloadBarBarButton()
    }
    func reloadBarBarButton(){
        let itemStyle = tableView.isEditing ? UIBarButtonSystemItem.done : UIBarButtonSystemItem.edit;
        let rightItem = UIBarButtonItem(barButtonSystemItem: itemStyle, target: self, action: #selector(SwipteToDeleteController.handleEditing(_:)))
        navigationItem.rightBarButtonItem = rightItem
    }
}

