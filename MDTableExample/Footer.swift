//
//  Footer.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/11.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

class MNThemeButton: UIButton{
    override var isHighlighted: Bool {
        didSet{
            if isHighlighted {
                self.backgroundColor = UIColor.theme
            }else{
                self.backgroundColor = UIColor.white
            }
        }
    }
}
class NMFooterView: UIView{
    var describleLabel: UILabel!
    var sortButton: MNThemeButton!
    private var separatorView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        describleLabel = UILabel.subTitle().added(to: self)
        describleLabel.text = "现在可以根据个人喜好,自由调整首页栏目顺序啦~"
        describleLabel.textAlignment = .center
        
        sortButton = MNThemeButton(type: .custom).added(to: self)
        sortButton.setTitle("调整栏目顺序", for: .normal)
        sortButton.setTitleColor(UIColor.theme, for: .normal)
        sortButton.setTitleColor(UIColor.white, for: .highlighted)
        sortButton.imageView?.contentMode = .scaleToFill
        sortButton.layer.borderWidth = 1.0
        sortButton.layer.borderColor = UIColor.theme.cgColor
        sortButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        separatorView = UIView().added(to: self)
        separatorView.backgroundColor = UIColor.groupTableViewBackground
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        describleLabel.sizeToFit()
        sortButton.sizeToFit()
        separatorView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1.0)
        describleLabel.frame = CGRect(x: 0, y: 16.0, width: self.frame.width, height: describleLabel.frame.height)
        let height = sortButton.frame.height
        let width = sortButton.frame.width + height
        let x = (self.frame.width - width) / 2.0
        let y = describleLabel.maxY + 8.0
        sortButton.frame = CGRect(x: x, y: y, width: width, height: height)
        sortButton.layer.cornerRadius = height / 2.0
        sortButton.layer.masksToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
