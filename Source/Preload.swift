//
//  Preload.swift
//  MDTable
//
//  Created by Leo on 2017/7/13.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation

/// Preload a row and save it to memory. So that when you scroll, you do not need to create this object any more.
class TablePreloader{
    var preloadMap = [String:UITableViewCell]()
    func preload(_ row:RowConvertable,tableView:UITableView){
        assert(Thread.isMainThread)
        switch row.initalType{
        case .code(let cellClass):
            let cell = cellClass.init(style: row.cellStyle, reuseIdentifier: row.reuseIdentifier)
            preloadMap[row.reuseIdentifier] = cell
        case .xib(let xibName):
            let nib = UINib(nibName: xibName, bundle: Bundle.main)
            tableView.register(nib, forCellReuseIdentifier: row.reuseIdentifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier)
            preloadMap[row.reuseIdentifier] = cell
        }
    }
    func reset(){
        preloadMap.removeAll()
    }
}
