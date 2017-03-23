//
//  FancyButton.swift
//  FZ Social
//
//  Created by Le Anh Duc on 3/23/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class FancyButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: GRAY_SHADOW, green: GRAY_SHADOW, blue: GRAY_SHADOW, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
