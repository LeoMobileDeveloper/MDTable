//
//  Section.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

struct SectionConvertableConst{
    static let defaultHeightForHeader:CGFloat = 0.0
    static let defaultEstimatedHeightForHeader:CGFloat = 30.0
    static let defaultHeightForFooter:CGFloat = 0.0
    static let defaultEstimatedHeightForFooter:CGFloat = 30.0
}

public protocol SectionConvertable {
    var rows:[RowConvertable] {get set}
    
    //These are optional
    var titleForHeader: String? {get}
    var viewForHeader: UIView? {get}
    var heightForHeader: CGFloat {get}
    var estimatedHeightForHeader: CGFloat {get}
    var willDisplayHeaderView:(UITableView,UIView,Int)->Void {get}
    var didEndDisplayingHeaderView:(UITableView,UIView,Int)->Void {get}
    
    var titleForFooter: String? {get}
    var viewForFooter: UIView? {get}
    var heightForFooter: CGFloat {get}
    var estimatedHeightForFooter: CGFloat {get}
    var willDisplayFooterView:(UITableView,UIView,Int)->Void {get}
    var didEndDisplayingFooterView:(UITableView,UIView,Int)->Void {get}
    
    var sectionIndexTitle:String?{get}
}

// MARK: - Header

extension SectionConvertable{
    public var titleForHeader: String? {
        return nil
    }
    public var viewForHeader: UIView?{
        return nil
    }
    public var heightForHeader: CGFloat{
        return SectionConvertableConst.defaultHeightForHeader
    }
    public var estimatedHeightForHeader: CGFloat{
        return SectionConvertableConst.defaultEstimatedHeightForHeader
    }
    public var willDisplayHeaderView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var didEndDisplayingHeaderView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
}


// MARK: - Footer

extension SectionConvertable{
    public var titleForFooter: String? {
        return nil
    }
    public var viewForFooter: UIView?{
        return nil
    }
    public var heightForFooter: CGFloat{
        return SectionConvertableConst.defaultHeightForFooter
    }
    public var estimatedHeightForFooter: CGFloat{
        return SectionConvertableConst.defaultEstimatedHeightForFooter
    }
    public var willDisplayFooterView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var didEndDisplayingFooterView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    
}

extension SectionConvertable{
    public var sectionIndexTitle:String?{
        return nil
    }
}