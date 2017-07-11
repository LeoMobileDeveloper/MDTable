//
//  CollectionViewCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/10.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

class ChannelCollectionCell:UICollectionViewCell{
    
    @IBOutlet weak var podcasterNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var describeLabel: UILabel!
    func config(_ channel:NMChannel){
        podcasterNameLabel.text = channel.podcasterName
        avatarImageView.asyncSetImage(channel.avatar)
        describeLabel.text = channel.describe
    }
}
