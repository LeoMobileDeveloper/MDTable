//
//  MVCollectionCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class MVCollectionCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    public func config(_ mv:NMMV){
        avatarImageView.asyncSetImage(mv.avatarImage)
        nameLabel.text = mv.avatarName
        singerLabel.text = mv.singerName
        playCountLabel.text = mv.playCount.asLocalizedPlayCount()
    }
}

class NMMV {
    let avatarImage:UIImage
    let avatarName:String
    let singerName:String
    let playCount:Int
    init(avatar:UIImage, name:String, singer:String, playCount:Int) {
        avatarImage = avatar
        avatarName = name
        singerName = singer
        self.playCount = playCount
    }
    
}
