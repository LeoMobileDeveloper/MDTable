//
//  NeteaseCloudMusicSortController.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/13.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class SortHeaderView: UIView{
    var imageView:UIImageView!
    var titleLabel:UILabel!
    var separatorView:UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel.subTitle().added(to: self)
        titleLabel.text = "想调整首页栏目的顺序?按住右边的按钮拖动即可"
        separatorView = UIView().added(to: self)
        separatorView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20.0, y: 0, width: self.frame.width - 20.0, height: self.frame.height)
        separatorView.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width, height: 1.0)
    }
}

class SortFooterView: UIView{
    
}

class NeteaseCloudMusicSortController: UITableViewController {
    var sections:[SortableSection]
    let editor = TableEditor()
    init(sections:[SortableSection]){
        self.sections = sections
        super.init(style: .plain)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "调整栏目顺序"
        let doneItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(NeteaseCloudMusicSortController.handleItemClicked(_:)))
        navigationItem.rightBarButtonItem = doneItem

        tableView.setEditing(true, animated: false)
        tableView.separatorColor = UIColor.groupTableViewBackground
        let rows = sections.map{ ReorderRow(title: $0.sortTitle)}
        let section = Section(rows: rows)
        tableView.manager = TableManager(sections: [section], editor: editor)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //Header
        tableView.tableHeaderView = SortHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
    }
    func handleItemClicked(_ sender: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
}
