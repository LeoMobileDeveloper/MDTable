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
        
        var sections = [Section]()
        for secionTitle in ["A","B","C","E","G","H","K","M","Z"]{
            var rows = [Row]()
            (1..<5).forEach{ (index) in
                rows.append(Row(title: "\(index)"))
            }
            let section = Section(rows: rows)
            section.heightForHeader = 30.0
            section.titleForHeader = secionTitle
            section.sectionIndexTitle = secionTitle
            sections.append(section)
        }
        tableView.manager = TableManager(sections: sections)
    }
}
