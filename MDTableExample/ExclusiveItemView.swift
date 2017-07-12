//
//  ExclusiveCollectionCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

enum ExclusiveStyle{
    case fullScreen
    case halfScreen
}

class ExclusiveItemView: UIView{
    var avatarImageView: UIImageView!
    var describeLabel: UILabel!
    var coverImageView:UIImageView!
    var discImageView:UIImageView!
    var style:ExclusiveStyle = .halfScreen
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
        describeLabel = UILabel.title().added(to: self)
        describeLabel.numberOfLines = 2
        discImageView = UIImageView().added(to: self)
        discImageView.image = UIImage(named: "cm4_disc_type_video")
    }
    func config(_ exclusive:NMExclusive,style:ExclusiveStyle){
        self.avatarImageView.asyncSetImage(exclusive.avatar)
        self.describeLabel.text = exclusive.describe
        self.style = style
        setNeedsLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var aspectRadio:CGFloat = 0.0
        switch self.style {
        case .halfScreen:
            aspectRadio = 158.0 / 87.0
        case .fullScreen:
            aspectRadio = 320.0 / 115.0
        }
        avatarImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width / aspectRadio)
        coverImageView.frame = avatarImageView.frame
        discImageView.frame = CGRect(x: 4.0, y: 4.0, width: 22.0, height: 22.0)
        describeLabel.frame = CGRect(x: 4.0, y: coverImageView.maxY + 4.0, width: self.frame.width - 8.0, height: 35.0)
    }
}
