//
//  ReactiveRow.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

open class ReactiveRow : RowConvertable{
    open var rowHeight:CGFloat
    open var reuseIdentifier: String
    open var initalType:RowConvertableInitalType
    open var indentationLevel: Int
    open var shouldHighlight: Bool
    public init(){
        self.rowHeight = 44.0
        self.reuseIdentifier = "Row"
        self.initalType = .code(className: MDTableViewCell.self)
        self.indentationLevel = 0
        self.shouldHighlight = true
    }
    var _render:((_ cell:UITableViewCell,_ isInital:Bool)->Void)?
    var _willDisplay:((UITableView,UITableViewCell,IndexPath)->Void)?
    var _didEndDisplaying:((UITableView,UITableViewCell,IndexPath)->Void)?
    var _accessoryButtonTappedForRowWith:((UITableView, IndexPath) -> Void)?
    var _willSelectedRowAt:((UITableView, IndexPath) -> IndexPath?)?
    var _willDeselectedRowAt:((UITableView, IndexPath) -> IndexPath?)?
    var _didSelectRowAt:((UITableView,IndexPath)->Void)?
    var _didDeselectRowAt:((UITableView,IndexPath)->Void)?
    var _didHighlightRowAt:((UITableView,IndexPath)->Void)?
    var _didUnhighlightRowAt:((UITableView,IndexPath)->Void)?
}

extension ReactiveRow{
    @discardableResult
    public func onRender(_ action:@escaping (_ cell: UITableViewCell,_ isInital: Bool)->Void)-> Self{
        self._render = action
        return self
    }
    @discardableResult
    public func onWillDisplay(_ action:@escaping (_ tableView:UITableView,_ cell:UITableViewCell,_ indexPath:IndexPath)->Void)-> Self{
        self._willDisplay = action
        return self
    }
    @discardableResult
    public func onDidEndDisplaying(_ action:@escaping (_ tableView:UITableView,_ cell:UITableViewCell,_ indexPath:IndexPath)->Void)-> Self{
        self._didEndDisplaying = action
        return self
    }
    @discardableResult
    public func onAccessoryButtonTapped(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)-> Self{
        self._accessoryButtonTappedForRowWith = action
        return self
    }
    
    @discardableResult
    public func onDidDeselectRowAt(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)-> Self{
        self._didDeselectRowAt = action
        return self
    }
    @discardableResult
    public func onDidSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)-> Self{
        self._didSelectRowAt = action
        return self
    }
    @discardableResult
    public func onWillSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->IndexPath?)-> Self{
        self._willSelectedRowAt = action
        return self
    }
    @discardableResult
    public func onWillDeSelected(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->IndexPath?)-> Self{
        self._willDeselectedRowAt = action
        return self
    }
    
    @discardableResult
    public func onDidHighlight(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)-> Self{
        self._didHighlightRowAt = action
        return self
    }
    @discardableResult
    public func onDidUnhighlight(_ action:@escaping (_ tableView:UITableView,_ indexPath:IndexPath)->Void)-> Self{
        self._didUnhighlightRowAt = action
        return self
    }
}

extension ReactiveRow{
    public var cellForRowAt:(UITableView, IndexPath) -> UITableViewCell{
        return { (tableView, indexPath) in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier){
                if let cell = cell as? MDTableViewCell{
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
                    if let cell = cell as? MDTableViewCell{
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
                    if let cell = cell as? MDTableViewCell{
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

}
extension ReactiveRow{
    public var willDisplay:(UITableView,UITableViewCell,IndexPath)->Void{
        return { (tableView, cell, indexPath) in
            self._willDisplay?(tableView, cell, indexPath)
        }
    }
    public var didEndDisplaying:(UITableView,UITableViewCell,IndexPath)->Void{
        return { (tableView, cell, indexPath) in
            self._didEndDisplaying?(tableView, cell, indexPath)
        }
    }
    public var accessoryButtonTappedForRowWith:(UITableView, IndexPath)->Void{
        return {tableView,indexPath in
            self._accessoryButtonTappedForRowWith?(tableView, indexPath)
        }
    }
}

// MARK: - Select

extension ReactiveRow{
    public var willSelectedRowAt:(UITableView, IndexPath) -> IndexPath?{
        return { (tableView, indexPath) in
            guard let _action = self._willSelectedRowAt else {
                return indexPath
            }
            return _action(tableView,indexPath)
        }
    }
    public var willDeselectedRowAt:(UITableView, IndexPath) -> IndexPath?{
        return { (tableView, indexPath) in
            guard let _action = self._willDeselectedRowAt else {
                return indexPath
            }
            return _action(tableView,indexPath)
        }
    }
    public var didSelectRowAt:(UITableView,IndexPath)->Void {
        return { tableView,indexPath in
            self._didSelectRowAt?(tableView, indexPath)
        }
    }
    public var didDeselectRowAt:(UITableView,IndexPath)->Void {
        return { tableView,indexPath in
            self._didDeselectRowAt?(tableView, indexPath)
        }
    }
}
// MARK: - Highlight

extension ReactiveRow{
    public var didHighlightRowAt:(UITableView,IndexPath)->Void {
        return { tableView,indexPath in
            self._didHighlightRowAt?(tableView, indexPath)
        }
    }
    public var didUnhighlightRowAt:(UITableView,IndexPath)->Void {
        return { tableView,indexPath in
            self._didUnhighlightRowAt?(tableView, indexPath)
        }
    }
}



