//
//  Focus.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit


public protocol TableFocusManager{
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    @available(iOS 9.0, *)
    func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    @available(iOS 9.0, *)
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
}
