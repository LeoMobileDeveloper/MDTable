//
//  Menu.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit


public protocol TableMenuManager{
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
}


