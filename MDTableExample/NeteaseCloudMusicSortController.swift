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
        imageView = UIImageView().added(to: self)
        imageView.image = UIImage(named: "cm2_icn_light")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 20.0, y: 0, width: self.frame.width - 20.0, height: self.frame.height)
        separatorView.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width, height: 1.0)
        let imageSize = CGSize(width: 9.0, height: 13.0)
        imageView.frame = CGRect(x: 8.0, y: self.frame.height / 2.0 - imageSize.height / 2.0, width: imageSize.width, height: imageSize.height)
    }
}

class SortFooterView: UIView{

}
protocol NeteaseCloudMusicSortControllerDelegate: class {
    func didFinishReorder(with sections:[SortableSection])
}
class NeteaseCloudMusicSortController: UITableViewController {
    var sections:[SortableSection]
    let editor = TableEditor()
    weak var delegate:NeteaseCloudMusicSortControllerDelegate?
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
        //Table
        tableView.tableHeaderView = SortHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
        tableView.setEditing(true, animated: false)
        tableView.separatorColor = UIColor.groupTableViewBackground
       
        //Manager
        let rows = sections.map{ ReorderRow(title: $0.sortTitle) }
        let section = Section(rows: rows)
        tableView.manager = TableManager(sections: [section], editor: editor)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        editor.moveRowAtSourceIndexPathToDestinationIndexPath = { tableView, fromIndexpath, toIndexPath in
            guard let manager = tableView.manager else{
                return
            }
            manager.move(from: fromIndexpath, to: toIndexPath)
            let section = self.sections.remove(at: fromIndexpath.row)
            self.sections.insert(section, at: toIndexPath.row)
            for i in 0..<self.sections.count{//Array is value type
                self.sections[i].sequence = i + 1
            }
        }
    }
    func handleItemClicked(_ sender: UIBarButtonItem){
        self.delegate?.didFinishReorder(with: self.sections)
        dismiss(animated: true, completion: nil)
    }
}
