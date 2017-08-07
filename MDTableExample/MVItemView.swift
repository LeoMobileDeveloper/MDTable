//
//  MVCollectionCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class MVItemView: UIView {
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var singerLabel: UILabel!
    var playCountLabel: UILabel!
    var coverImageView:UIImageView!
    var discImageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit(){
        avatarImageView = UIImageView().added(to: self)
        coverImageView = UIImageView().added(to: self)
        coverImageView.image = UIImage(named: "cm4_cover_top_mask")
        discImageView = UIImageView().added(to: self)
        discImageView.image = UIImage(named: "cm4_cover_icn_video")
        playCountLabel = UILabel().added(to: self)
        playCountLabel.textColor = UIColor.white
        playCountLabel.font = UIFont.systemFont(ofSize: 10)
        nameLabel = UILabel.title().added(to: self)
        singerLabel = UILabel.subTitle().added(to: self)
    }
    public func config(_ mv:NMMV){
        avatarImageView.asyncSetImage(mv.avatarImage)
        nameLabel.text = mv.avatarName
        singerLabel.text = mv.singerName
        playCountLabel.text = mv.playCount.asLocalizedPlayCount()
        layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width / 62.0 * 35.0)
        coverImageView.frame = avatarImageView.frame
        playCountLabel.sizeToFit()
        playCountLabel.frame = CGRect(x: self.frame.width - 6.0 - playCountLabel.frame.width, y: 4.0, width: playCountLabel.frame.width, height: playCountLabel.frame.height)
        discImageView.frame = CGRect(x: playCountLabel.x - 12.0 - 4.0, y: 4.0, width: 12.0, height: 12.0)
        nameLabel.frame = CGRect(x: 4.0, y: avatarImageView.maxY + 4.0, width: self.frame.width - 8.0, height: 15.0)
        singerLabel.frame = CGRect(x: 4.0, y: nameLabel.maxY + 4.0, width: self.frame.width - 8.0, height: 15.0)
    }
}

class NMMV {
    let avatarImage:UIImage?
    let avatarName:String
    let singerName:String
    let playCount:Int
    init(avatar:UIImage?, name:String, singer:String, playCount:Int) {
        avatarImage = avatar
        avatarName = name
        singerName = singer
        self.playCount = playCount
    }
}
