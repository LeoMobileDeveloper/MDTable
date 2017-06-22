//
//  SectionIndexTitleController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/17.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class SectionIndexTitleController: UITableViewController {
    var tableManager:TableManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelectionDuringEditing = false
        navigationItem.title = "Index Titles"
        
        var sections = [SystemSection]()
        for secionTitle in ["A","B","C","E","G","H","K","M","Z"]{
            var rows = [SystemRow]()
            (1..<5).forEach{ (index) in
                rows.append(SystemRow(title: "\(index)"))
            }
            let section = SystemSection(rows: rows)
            section.heightForHeader = 30.0
            section.titleForHeader = secionTitle
            section.sectionIndexTitle = secionTitle
            sections.append(section)
        }
        tableManager = TableManager(sections: sections)
        tableView.md_bindTo(manager: tableManager)
    }
}
