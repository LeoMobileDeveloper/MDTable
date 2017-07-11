//
//  ExclusiveCollectionCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

enum ExclusiveAspectRadio{
    case fullScreen
    case halfScreen
}

class ExclusiveCollectionCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var aspectRadioConstraint: NSLayoutConstraint!
    func config(_ exclusive:NMExclusive){
        self.avatarImageView.asyncSetImage(exclusive.avatar)
        self.describeLabel.text = exclusive.describe
    }
    func remakeAspectRadio(_ radio:ExclusiveAspectRadio){
        avatarImageView.removeConstraint(aspectRadioConstraint)
        var newAspectRadio:CGFloat = 0.0
        switch radio {
        case .fullScreen:
            newAspectRadio = 158.0 / 87.0
        case .halfScreen:
            newAspectRadio = 320.0 / 115.0
        }
        let constraint = NSLayoutConstraint.init(item: avatarImageView,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: avatarImageView,
                                                  attribute: .height,
                                                  multiplier: newAspectRadio,
                                                  constant: 0);
        avatarImageView.addConstraint(constraint)
        aspectRadioConstraint = constraint
    }
}
