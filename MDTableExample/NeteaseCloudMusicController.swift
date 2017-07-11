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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "网易云音乐"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        
        let menuSection = MenuSection.mockSection
        let recommendSection = RecommendSection.mockSection
        let exclusiveSection = ExclusiveSection.mockSection
        let mvSection = NMMVSection.mockSection
        let columnistSection = NeteaseColumnlistSection.mockSection
        let channelSection = ChannelSection.mockSection
        let latestMusicSection = LatestMusicSection.mockSection
        let sections = [menuSection,recommendSection,exclusiveSection,mvSection,columnistSection,channelSection,latestMusicSection]
        tableView.manager = TableManager(sections: sections)
    }
}


