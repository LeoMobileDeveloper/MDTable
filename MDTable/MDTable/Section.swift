//
//  Section.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

open class Section:SectionConvertable{
    public var rows: [RowConvertable]
    public init(rows:[RowConvertable]){
        self.rows = rows
    }
    //Optional
    public var titleForHeader: String?
    public var viewForHeader: UIView?
    public var heightForHeader: CGFloat = SectionConvertableConst.defaultHeightForHeader
    
    public var titleForFooter: String?
    public var viewForFooter: UIView?
    public var heightForFooter: CGFloat = 0.0
    
    public var sectionIndexTitle: String? = nil
}
