//
//  CollectionViewCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/10.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

class ChannelItemView:AvatarItemView{
    
    var coverImageview: UIImageView!
    var podcasterNameLabel: UILabel!
    var describeLabel: UILabel!
    func config(_ channel:NMChannel){
        podcasterNameLabel.text = channel.podcasterName
        avatarImageView.asyncSetImage(channel.avatar)
        describeLabel.text = channel.describe
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        coverImageview = UIImageView().added(to: self)
        describeLabel = UILabel.title().added(to: self)
        describeLabel.numberOfLines = 2
        podcasterNameLabel = UILabel.title().added(to: self)
        podcasterNameLabel.textColor = UIColor.white
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        coverImageview.frame = avatarImageView.frame
        describeLabel.frame = CGRect(x: 4.0, y: avatarImageView.maxY + 4.0, width: self.frame.width - 8.0, height: 30.0)
        podcasterNameLabel.sizeToFit()
        podcasterNameLabel.frame = CGRect(x: 4.0, y: coverImageview.maxY - 2.0 - podcasterNameLabel.frame.height, width: describeLabel.frame.width, height: podcasterNameLabel.frame.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
