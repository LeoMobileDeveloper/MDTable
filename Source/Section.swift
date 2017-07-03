//
//  Section.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

struct SectionConst{
    static let defaultHeightForHeader:CGFloat = 0.0
    static let defaultEstimatedHeightForHeader:CGFloat = 30.0
    static let defaultHeightForFooter:CGFloat = 0.0
    static let defaultEstimatedHeightForFooter:CGFloat = 30.0
}

open class ReactiveSection:SectionConvertable{
    public var rows: [RowConvertable] = []
    
    //Optional
    public var titleForHeader: String?
    public var heightForHeader: CGFloat = SectionConst.defaultHeightForHeader
    public var estimatedHeightForHeader: CGFloat = SectionConst.defaultEstimatedHeightForHeader

    public var titleForFooter: String?
    public var heightForFooter: CGFloat = 0.0
    public var estimatedHeightForFooter: CGFloat = SectionConst.defaultEstimatedHeightForFooter
    public var sectionIndexTitle: String? = nil
    
    var _viewForHeader:((UITableView,Int)->UIView?)?
    var _willDisplayHeaderView:((UITableView,UIView,Int)->Void)?
    var _didEndDisplayingHeaderView:((UITableView,UIView,Int)->Void)?
    
    var _viewForFooter:((UITableView,Int)->UIView?)?
    var _willDisplayFooterView:((UITableView,UIView,Int)->Void)?
    var _didEndDisplayingFooterView:((UITableView,UIView,Int)->Void)?
}

extension ReactiveSection{
    @discardableResult
    public func withHeaderView(_ creator:@escaping (UIView,Int)->UIView?)->Self{
        self._viewForHeader = creator
        return self
    }
    @discardableResult
    public func withFooterView(_ creator:@escaping (UIView,Int)->UIView?)->Self{
        self._viewForFooter = creator
        return self
    }
    public func onWillDisplayHeaderView(_ action:@escaping (UITableView,UIView,Int)->Void)-> Self{
        self._willDisplayHeaderView = action
        return self
    }
    public func onDidEndDisplayingHeaderView(_ action:@escaping (UITableView,UIView,Int)->Void)-> Self{
        self._didEndDisplayingHeaderView = action
        return self
    }
    public func onWillDisplayFooterView(_ action:@escaping (UITableView,UIView,Int)->Void)-> Self{
        self._willDisplayFooterView = action
        return self
    }
    public func onDidEndDisplayingFooterView(_ action:@escaping (UITableView,UIView,Int)->Void)-> Self{
        self._didEndDisplayingFooterView = action
        return self
    }
}

extension ReactiveSection{
    public var willDisplayHeaderView:(UITableView,UIView,Int)->Void{
        return {tableView,view,section in
            self._willDisplayHeaderView?(tableView,view,section)
        }
    }
    public var didEndDisplayingHeaderView:(UITableView,UIView,Int)->Void{
        return {tableView,view,section in
            self._didEndDisplayingHeaderView?(tableView,view,section)
        }
    }
    public var viewForHeader:(UITableView,Int)->UIView?{
        return {tableView,section in
            self._viewForHeader?(tableView,section)
        }
    }
    public var willDisplayFooterView:(UITableView,UIView,Int)->Void{
        return {tableView,view,section in
            self._willDisplayFooterView?(tableView,view,section)
        }
    }
    public var didEndDisplayingFooterView:(UITableView,UIView,Int)->Void{
        return {tableView,view,section in
            self._didEndDisplayingFooterView?(tableView,view,section)
        }
    }
    public var viewForFooter:(UITableView,Int)->UIView?{
        return {tableView,section in
            self._viewForFooter?(tableView,section)
        }
    }
}
open class Section:ReactiveSection{
    public init(rows:[RowConvertable]){
        super.init()
        self.rows = rows
    }
}
