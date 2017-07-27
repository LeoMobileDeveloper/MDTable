//
//  Util.swift
//  MDTable
//
//  Created by Leo on 2017/7/27.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation

func executeOnMain(_ block:@escaping (Void)->Void){
    if Thread.isMainThread{
        block()
    }else{
        DispatchQueue.main.async {
            block()
        }
    }
}
