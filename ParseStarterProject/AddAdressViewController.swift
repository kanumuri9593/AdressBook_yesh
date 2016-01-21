//
//  AddAdressViewController.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit

class AddAdressViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var currentAdress: UILabel!
    
    @IBOutlet weak var nameTitle: materialTextfield!
    
    @IBOutlet weak var note: materialTextfield!

    @IBOutlet weak var adress1: materialTextfield!
    
    @IBOutlet weak var adress2: materialTextfield!
    
    @IBOutlet weak var city: materialTextfield!
    
    
    @IBAction func addAdress(sender: AnyObject) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
