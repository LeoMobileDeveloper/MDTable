//
//  MusicCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

/// 歌单
class MusicSheetCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    func config(_ recommend:NMRecommend){
        self.describeLabel.text = recommend.describe
        self.playCountLabel.text = recommend.playCount.asLocalizedPlayCount()
        self.avatarImageView.asyncSetImage(recommend.avatar)
    }
}

class NMRecommend {
    var describe:String
    var avatar:UIImage
    var playCount:Int
    init(avatar:UIImage, playCount:Int,describe:String){
        self.avatar = avatar
        self.playCount = playCount
        self.describe = describe
    }
}
