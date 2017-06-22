//
//  CustomCellWithCodeController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class CustomCellWithCodeController: UITableViewController {
    var tableManager:TableManager!
    let appendArray = ["Wardell Stephen Curry II (born March 14, 1988) is an American professional basketball player for the Golden State Warriors of the National Basketball Association (NBA). ",
                       "Many players and analysts have called him the greatest shooter in NBA history.[1] In 2014–15, Curry won the NBA Most Valuable Player Award and led the Warriors to their first championship since 1975. The following season, he became the first player in NBA history to be elected MVP by a unanimous vote and to lead the league in scoring while shooting above 50–40–90. That same year, the Warriors broke the record for the most wins in an NBA season. After losing in the NBA Finals in 2016, Curry helped the Warriors return to the Finals for a third straight year in 2017, where he claimed his second NBA Championship.",
                       "Curry is the son of former NBA player Dell Curry and older brother of current NBA player Seth Curry. He played college basketball for Davidson. There, he was twice named Southern Conference Player of the Year and set the all-time scoring record for both Davidson and the Southern Conference. During his sophomore year, he also set the single-season NCAA record for three-pointers made.",
                       "During the 2012–13 season, Curry set the NBA record for three-pointers made in a regular season with 272. He surpassed that record in 2015 with 286, and again in 2016 with 402. During the 2013–14 season, he and teammate Klay Thompson were nicknamed the 'Splash Brothers' en route to setting the NBA record for combined three-pointers in a season with 484, a record they broke the following season (525) and again in the 2015–16 season (678)."]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Custom cell with Code"
        let rows = (1..<100).map { (index) -> CustomCodeRow in
            let random = Int(arc4random()) % appendArray.count
            let content = appendArray[random]
            let row = CustomCodeRow(title: content)
            row.didSelectRowAt = {  [unowned self] (tableView, indexPath) in
                self.tableManager.delete(row: indexPath)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            return row
        }
        let section = SystemSection(rows: rows)
        section.heightForHeader = 30.0
        section.titleForHeader = "Tap Row to Delete"
        tableManager = TableManager(sections: [section])
        tableView.md_bindTo(manager: tableManager)
    }

}
