//
//  CusomCellWithXib.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class CusomCellWithXib: MDTableViewCell{

    @IBOutlet weak var customSubTitleLabel: UILabel!
    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var avaterImageView: UIImageView!
    
    override func render(with row: RowConvertable) {
        guard let row = row as? XibRow else{
            return;
        }
        customTitleLabel.text = row.title
        customSubTitleLabel.text = row.subTitle
        avaterImageView.image = row.image
    }
}
