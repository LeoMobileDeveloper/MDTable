//
//  BaseRow.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

open class Row{
    public var image:UIImage?
    public var title:String
    public var detailTitle:String?
    public var accessoryType: UITableViewCellAccessoryType
    public var rowHeight:CGFloat
    public var cellStyle: UITableViewCellStyle = .default
    public var reuseIdentifier = "RowCell"
    public var initalType: RowConvertableInitalType = RowConvertableInitalType.code(className: SystemTableViewCell.self)
    var _render:((_ cell:UITableViewCell,_ isInital:Bool)->Void)?
    var _didSelect:((UITableView,IndexPath)->Void)?
    
    public init(title:String,
                image:UIImage? = nil,
                detailTitle:String? = nil,
                rowHeight:CGFloat = 44.0,
                accessoryType: UITableViewCellAccessoryType = .none) {
        self.image = image
        self.title = title
        self.detailTitle = detailTitle
        self.accessoryType = accessoryType
        self.rowHeight = rowHeight
    }
}

extension Row{
    @discardableResult
    public func onRender(_ action:@escaping (_ cell: UITableViewCell,_ isInital: Bool)->Void)->Row{
        self._render = action
        return self
    }
    @discardableResult
    public func onDidSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)->Row{
        self._didSelect = action
        return self
    }
}

extension Row:RowConvertable{
    
    public var cellForRowAt:(UITableView, IndexPath) -> UITableViewCell{
        return { (tableView, indexPath) in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier){
                if let cell = cell as? SystemTableViewCell{
                    cell.render(with: self)
                }
                if let _render = self._render{
                    _render(cell,false)
                }
                return cell;
            }else{
                switch self.initalType{
                case .code(let cellClass):
                    let cell = cellClass.init(style: self.cellStyle, reuseIdentifier: self.reuseIdentifier)
                    if let cell = cell as? SystemTableViewCell{
                        cell.render(with: self)
                    }
                    if let _render = self._render{
                        _render(cell,true)
                    }
                    return cell
                case .xib(let xibName):
                    let nib = UINib(nibName: xibName, bundle: Bundle.main)
                    tableView.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
                    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier)
                    if let cell = cell as? SystemTableViewCell{
                        cell.render(with: self)
                    }
                    if let _render = self._render, let cell = cell{
                        _render(cell,true)
                    }
                    return cell!
                }
            }
        }
    }
    public var didSelectRowAt:(UITableView,IndexPath)->Void{
        return { (tableView, indexPath) in
            if let _didSelect = self._didSelect{
                _didSelect(tableView, indexPath)
            }
        }
    }
}
