//
//  AvatarItemView.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/14.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

class HightLightImageView: UIImageView{
    lazy var highLightCoverView: UIView = {
        let view = UIView().added(to: self)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AvatarItemView: UIView, UIGestureRecognizerDelegate {
    open var avatarImageView: HightLightImageView!
    var highLightGesture: UILongPressGestureRecognizer!
    var tapGesture: UITapGestureRecognizer!
    var longPresssGesture: UILongPressGestureRecognizer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatarImageView = HightLightImageView(frame: CGRect.zero).added(to: self)
       
        highLightGesture = UILongPressGestureRecognizer(target: self, action: #selector(AvatarItemView.handleHight(_:)))
        highLightGesture.delegate = self
        highLightGesture.minimumPressDuration = 0.1
        self.addGestureRecognizer(highLightGesture)

        tapGesture = UITapGestureRecognizer(target: self, action: #selector(AvatarItemView.handleTap(_:)))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
        longPresssGesture = UILongPressGestureRecognizer(target: self, action: #selector(AvatarItemView.handleLongPress(_:)))
        longPresssGesture.minimumPressDuration = 1.0
        longPresssGesture.delegate = self
        self.addGestureRecognizer(longPresssGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self){
            return false
        }
        if gestureRecognizer == longPresssGesture {
            return false
        }
        return true
    }
    func handleHight(_ sender: UILongPressGestureRecognizer){
        switch sender.state {
        case .began,.changed:
            let location = sender.location(in: self)
            let touchInside = self.bounds.contains(location)
            avatarImageView.highLightCoverView.isHidden = !touchInside
        default:
            avatarImageView.highLightCoverView.isHidden = true
        }
    }
    func handleTap(_ sender: UITapGestureRecognizer){
        print("Tap")
    }
    
    func handleLongPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began{
            print("LongPress")
        }
    }
}
