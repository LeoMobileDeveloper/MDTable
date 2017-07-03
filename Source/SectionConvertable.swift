//
//  Section.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

public protocol SectionConvertable {
    var rows:[RowConvertable] {get set}
    
    //These are optional
    var titleForHeader: String? {get}
    var heightForHeader: CGFloat {get}
    var estimatedHeightForHeader: CGFloat {get}
    
    var titleForFooter: String? {get}
    var heightForFooter: CGFloat {get}
    var estimatedHeightForFooter: CGFloat {get}
    
    var sectionIndexTitle:String?{get}

    var viewForHeader:(UITableView,Int)->UIView? {get}
    var willDisplayHeaderView:(UITableView,UIView,Int)->Void {get}
    var didEndDisplayingHeaderView:(UITableView,UIView,Int)->Void {get}
    
    var viewForFooter:(UITableView,Int)->UIView? {get}
    var willDisplayFooterView:(UITableView,UIView,Int)->Void {get}
    var didEndDisplayingFooterView:(UITableView,UIView,Int)->Void {get}
    
}

// MARK: - Header

extension SectionConvertable{
    public var titleForHeader: String? {
        return nil
    }
    public var heightForHeader: CGFloat{
        return SectionConst.defaultHeightForHeader
    }
    public var estimatedHeightForHeader: CGFloat{
        return SectionConst.defaultEstimatedHeightForHeader
    }
    public var willDisplayHeaderView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var didEndDisplayingHeaderView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var viewForHeader:(UITableView,Int)->UIView?{
        return {_,_ in return nil}
    }

}


// MARK: - Footer

extension SectionConvertable{
    public var titleForFooter: String? {
        return nil
    }
    public var heightForFooter: CGFloat{
        return SectionConst.defaultHeightForFooter
    }
    public var estimatedHeightForFooter: CGFloat{
        return SectionConst.defaultEstimatedHeightForFooter
    }
    public var willDisplayFooterView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var didEndDisplayingFooterView:(UITableView,UIView,Int)->Void{
        return {_,_,_ in}
    }
    public var viewForFooter:(UITableView,Int)->UIView?{
        return {_,_ in return nil}
    }
}

extension SectionConvertable{
    public var sectionIndexTitle:String?{
        return nil
    }
}
