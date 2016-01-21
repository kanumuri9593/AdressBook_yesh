//
//  materialButton.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import UIKit

class materialButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
    }
    
    
}
