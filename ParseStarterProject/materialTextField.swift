//
//  materialTextField.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation

import UIKit

class materialTextfield: UITextField {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.1).CGColor
        layer.borderWidth = 1.0
        
    }
    
    // for place holder
    
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    // for editable text
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
    
    
}
