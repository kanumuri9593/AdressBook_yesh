//
//  adrees.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import Foundation
import Parse



class adress {


    private var _title :String!
    private var _note :String!

    
    
    var title : String {
        
        return _title
        
    }
    
    var note :String {
        
        
        return _note
    }

    
    init (title :String , note:String ) {
        
        self._title = title
        self._note = note
        
        
        
    }


}
