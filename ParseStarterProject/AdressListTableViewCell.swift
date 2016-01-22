//
//  AdressListTableViewCell.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class AdressListTableViewCell: UITableViewCell {
    
    
    var locationadress: adress!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var noteLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell ( a:adress ) {
    
    
    self.locationadress = a
        
        
        self.titleLbl.text = a.title
        self.noteLbl.text = a.note
 
    }
    

}
