//
//  DynamicHeightCellController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class DynamicHeightCellController: UITableViewController {
    var tableManager:TableManager!
    let appendArray = ["Wardell Stephen Curry II (born March 14, 1988) is an American professional basketball player for the Golden State Warriors of the National Basketball Association (NBA). ",
                       "Many players and analysts have called him the greatest shooter in NBA history.[1] In 2014–15.",
                       "Curry is the son of former NBA player Dell Curry and older brother of current NBA player Seth Curry.",
                       "During the 2012–13 season, Curry set the NBA record for three-pointers made in a regular season with 272. He surpassed that record in 2015 with 286, and again in 2016 with 402. During the 2013–14 season, he and teammate Klay Thompson were nicknamed the 'Splash Brothers' en route to setting the NBA record for combined three-pointers in a season with 484, a record they broke the following season (525) and again in the 2015–16 season (678)."]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Custom cell with Code"
        let rows = (1..<100).map { (index) -> DynamicHeightRow in
            let random = Int(arc4random()) % appendArray.count
            let content = appendArray[random]
            let row = DynamicHeightRow(title: content)
            row.didSelectRowAt = { (tableView, indexPath) in
                tableView.manager?.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return row
        }
        let section = Section(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableView.manager = TableManager(sections: [section])
    }

}
