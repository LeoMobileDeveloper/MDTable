//
//  ComplexController.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/17.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class NeteaseCloudMusicController: UITableViewController {
    
    var sections: [SectionConvertable] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "网易云音乐"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        let footer = NMFooterView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 85.0))
        tableView.tableFooterView = footer
        footer.sortButton.addTarget(self, action: #selector(NeteaseCloudMusicController.showSortController(_:)), for: .touchUpInside)
        
        let menuSection = MenuSection.mockSection
        let recommendSection = RecommendSection.mockSection
        let exclusiveSection = ExclusiveSection.mockSection
        let mvSection = NMMVSection.mockSection
        let columnistSection = NeteaseColumnlistSection.mockSection
        let channelSection = ChannelSection.mockSection
        let latestMusicSection = LatestMusicSection.mockSection
        sections = [menuSection,recommendSection,exclusiveSection,mvSection,columnistSection,channelSection,latestMusicSection]
        tableView.manager = TableManager(sections: sections)
    }
    
    func showSortController(_ sender: UIBarButtonItem){
        let sortableSections = sections.filter { $0 is SortableSection }.map{$0 as! SortableSection}
        let sortController = NeteaseCloudMusicSortController(sections: sortableSections)
        let navController = BaseNavigationController(rootViewController: sortController)
        present(navController, animated: true, completion: nil)
    }
    
}


