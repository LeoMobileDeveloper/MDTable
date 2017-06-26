//
//  MDTable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public extension UITableView{
    func md_bindTo(manager:TableManager){
        manager.bindTo(tableView: self)
    }
}

open class SystemRow{
    public var image:UIImage?
    public var title:String
    public var detailTitle:String?
    public var accessoryType: UITableViewCellAccessoryType
    public var rowHeight:CGFloat
    public var cellStyle: UITableViewCellStyle = .default
    public var reuseIdentifier = "SystemRowCell"
    public var initalType: TableRowInitalType = TableRowInitalType.code(className: SystemTableViewCell.self)
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

extension SystemRow{
    @discardableResult
    public func onRender(_ action:@escaping (_ cell: UITableViewCell,_ isInital: Bool)->Void)->SystemRow{
        self._render = action
        return self
    }
    @discardableResult
    public func onDidSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)->SystemRow{
        self._didSelect = action
        return self
    }
}

extension SystemRow:TableRow{

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

open class SystemSection:TableSection{
    public var rows: [TableRow]
    public init(rows:[TableRow]){
        self.rows = rows
    }
    //Optional
    public var titleForHeader: String?
    public var viewForHeader: UIView?
    public var heightForHeader: CGFloat = TableSectionConst.defaultHeightForHeader
    
    public var titleForFooter: String?
    public var viewForFooter: UIView?
    public var heightForFooter: CGFloat = 0.0
    
    public var sectionIndexTitle: String? = nil
}

open class SystemTableEditor:TableEditor{
    public var editingStyleCommitForRowAt: (UITableView, UITableViewCellEditingStyle, IndexPath) -> Void
    public var willBeginEditingRowAt:(UITableView, IndexPath) -> Void
    public var didEndEditingRowAt:(UITableView, IndexPath?) -> Void
    public var moveRowAtSourceIndexPathToDestinationIndexPath:(UITableView, IndexPath, IndexPath)->Void
    public init(){
        editingStyleCommitForRowAt = { (_,_,_) in}
        moveRowAtSourceIndexPathToDestinationIndexPath = { (_,_,_) in}
        willBeginEditingRowAt = {(_,_) in}
        didEndEditingRowAt = {(_,_) in}
    }
}
