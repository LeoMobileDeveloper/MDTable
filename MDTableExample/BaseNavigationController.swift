//
//  BaseNavigationController.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/13.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return .lightContent
        }
    }
}
