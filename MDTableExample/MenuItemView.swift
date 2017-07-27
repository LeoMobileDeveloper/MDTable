//
//  MenuItemView.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/25.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

class MenuItemView: UIView,UIGestureRecognizerDelegate {
    var backgroundImageView:UIImageView!
    var foregroundImageView:UIImageView!
    var textLabel:UILabel!
    var dateLabel:UILabel!
    var highLightGesture: UILongPressGestureRecognizer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundImageView = UIImageView().added(to: self)
        foregroundImageView = UIImageView().added(to: self)
        textLabel = UILabel.title().added(to: self)
        textLabel.textAlignment = .center
        backgroundImageView.image = UIImage(named: "cm4_disc_topbtn")
        dateLabel = UILabel.title().added(to: self)
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.theme
        highLightGesture = UILongPressGestureRecognizer(target: self, action: #selector(AvatarItemView.handleHight(_:)))
        highLightGesture.delegate = self
        highLightGesture.minimumPressDuration = 0.1
        self.addGestureRecognizer(highLightGesture)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self){
            return false
        }
        return true
    }
    func handleHight(_ sender: UILongPressGestureRecognizer){
        switch sender.state {
        case .began,.changed:
            let location = sender.location(in: self)
            let touchInside = self.bounds.contains(location)
            if touchInside{
                foregroundImageView.isHighlighted = true
                dateLabel.textColor = UIColor.white
            }else{
                foregroundImageView.isHighlighted = false
                dateLabel.textColor = UIColor.theme
            }
        default:
            foregroundImageView.isHighlighted = false
            dateLabel.textColor = UIColor.theme
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        backgroundImageView.center = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0 - 10.0)
        textLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 18.0)
        textLabel.center = CGPoint(x: self.frame.width / 2.0, y: backgroundImageView.maxY +  textLabel.frame.height / 2.0 + 8)
        foregroundImageView.frame = backgroundImageView.frame
        dateLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 18.0)
        dateLabel.center = CGPoint(x: self.frame.width / 2.0, y: backgroundImageView.center.y + 2.0)
    }
    
}

class DateMenuItemView:MenuItemView{
    var timeLabel:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        timeLabel = UILabel.subTitle().added(to: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        timeLabel.sizeToFit()
        timeLabel.center = backgroundImageView.center
    }
}
