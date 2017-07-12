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
    
    var coverImageView: UIImageView!
    var describeLabel: UILabel!
    var playCountLabel: UILabel!
    var avatarImageView: UIImageView!
    var listenIconImageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        avatarImageView = UIImageView().added(to: contentView)
        coverImageView = UIImageView().added(to: contentView)
        coverImageView.image = UIImage(named: "cm4_cover_top_mask")
        describeLabel = UILabel.title().added(to: contentView)
        describeLabel.numberOfLines = 2
        playCountLabel = UILabel.title().added(to: contentView)
        playCountLabel.textColor = UIColor.white
        playCountLabel.font = UIFont.systemFont(ofSize: 10)
        listenIconImageView = UIImageView().added(to: contentView)
        listenIconImageView.image = UIImage(named: "cm4_cover_icn_music")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playCountLabel.sizeToFit()
        avatarImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.width)
        coverImageView.frame = avatarImageView.frame
        describeLabel.frame = CGRect(x: 4.0, y: avatarImageView.maxY, width: contentView.frame.width - 8.0, height: 30.0)
        playCountLabel.frame = CGRect(x: contentView.frame.width - 2.0 - playCountLabel.frame.width, y: 2.0, width: playCountLabel.frame.width, height: playCountLabel.frame.height)
        listenIconImageView.frame = CGRect(x: playCountLabel.x - 12.0 - 2.0, y: 2.0, width: 12.0, height: 12.0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
