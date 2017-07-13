//
//  SortableSection.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/13.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation

protocol SortableSection {
    var sortTitle: String {get set}
    var sequence: Int {get}
    var defaultSequeue:Int {get}
}
