//
//  MainTableViewController.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class MainTableViewController: UITableViewController {

    var tableManager:TableManager?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        let rowClickAction:(UITableView,IndexPath,UIViewController.Type)->Void = {  [unowned self] (tableView, indexPath, controllerClass) in
            tableView.deselectRow(at: indexPath, animated: true)
            let tvc = controllerClass.init()
            self.navigationController?.pushViewController(tvc, animated: true)
        }
        // Section 0
        let row0_0 = Row(title: "System Cell", accessoryType: .disclosureIndicator)
        let row0_1 = Row(title: "Dynamic Height", accessoryType: .disclosureIndicator)
        let row0_2 = Row(title: "Custom Cell with XIB", accessoryType: .disclosureIndicator)
        let row0_3 = Row(title: "网易云音乐", accessoryType: .disclosureIndicator)
        let section0Controllers:[UIViewController.Type] = [SystemCellController.self,
                                   DynamicHeightCellController.self,
                                   CustomCellWithXibController.self,
                                   NeteaseCloudMusicController.self]
        let rows_0 = [row0_0, row0_1, row0_2, row0_3]
        zip(rows_0, section0Controllers).forEach {
            let (row, controller) = $0
            row.onDidSelected({ (tableView, indexPath) in
                rowClickAction(tableView, indexPath, controller)
            })
        }
        let section0 = Section(rows: rows_0)
        section0.heightForHeader = 30.0
        section0.titleForHeader = "Basic"
        
        //Section 1
        let row1_0 = Row(title: "Swpite to delete", accessoryType: .disclosureIndicator)
        let row1_1 = Row(title: "Reorder", accessoryType: .disclosureIndicator)
        let row1_2 = Row(title: "Index Title", accessoryType: .disclosureIndicator)
        
        let section1Controllers:[UIViewController.Type] = [SwipteToDeleteController.self,
                                   ReorderTableViewController.self,
                                   SectionIndexTitleController.self]
        let rows_1 = [row1_0,row1_1,row1_2]
        zip(rows_1, section1Controllers).forEach {
            let (row, controller) = $0
            row.onDidSelected({ (tableView, indexPath) in
                rowClickAction(tableView, indexPath, controller)
            })
        }
        let section1 = Section(rows: rows_1)
        section1.titleForHeader = "Advanced"
        section1.heightForHeader = 30.0

        tableView.manager = TableManager(sections: [section0,section1])
        
        //Add FPS Label
        let fpsLabel = FPSLabel(frame: CGRect(x: UIScreen.main.bounds.width - 45.0, y:UIScreen.main.bounds.height - 25.0 , width: 40.0, height: 20.0))
        UIApplication.shared.keyWindow?.addSubview(fpsLabel)
    }
}

