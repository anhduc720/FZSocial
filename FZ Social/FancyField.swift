//
//  FancyField.swift
//  FZ Social
//
//  Created by Le Anh Duc on 3/23/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class FancyField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: GRAY_SHADOW, green: GRAY_SHADOW, blue: GRAY_SHADOW, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        	
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
