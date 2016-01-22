//
//  NavigateViewController.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MapKit

class NavigateViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var namelbl: materialLabel!
    
    @IBOutlet weak var noteLbl: materialLabel!
    
    
    @IBOutlet weak var adress1Lbl: materialLabel!
    
    
    @IBOutlet weak var adress2Lbl: materialLabel!
    
    
    @IBOutlet weak var cityLbl: materialLabel!
    
    var requestLocation :CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var name: String = ""
    var note: String = ""
    var adress1: String = ""
    var adress2: String = ""
    var city: String = ""
    var pin: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(adress1 + adress2 + city + pin )
        

        
       namelbl.text = name
        
        noteLbl.text = note
        
        adress1Lbl.text = adress1
        
        adress2Lbl.text = adress2
        
        cityLbl.text = city + ",Pin : " + pin
        
        
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        
        
        
        
        var objectAnnotation = MKPointAnnotation()
        
        objectAnnotation.coordinate = requestLocation
        
        objectAnnotation.title = "Destination"
        
        self.map.addAnnotation(objectAnnotation)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
    
    
    
    @IBAction func statrtNavigation(sender: AnyObject) {
        
        print(PFUser.currentUser()!.username!)
        
        
        var query = PFQuery(className:"AdressList")
        
         print(PFUser.currentUser()!.username!)
        
        query.whereKey("username", equalTo:PFUser.currentUser()!.username!)
        
         print(PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                
                //print("Successfully retrieved \(objects!) .")
                
                // Do something with the found objects
                if let objects = objects {
                    
                    
                    
                    for object in objects {

                        
                 
                                
                                let requestCLLocation = CLLocation(latitude: self.requestLocation.latitude, longitude: self.requestLocation.longitude)
                                
                                CLGeocoder().reverseGeocodeLocation(requestCLLocation, completionHandler: {(placemarks, error)-> Void in
                                    
                                    if (error != nil) {
                                        print("Reverse geocoder failed with error" + error!.localizedDescription)
                                        
                                    } else {
                                        
                                        if placemarks!.count > 0 {
                                            let pm = placemarks![0] as! CLPlacemark
                                            
                                            let mkPm = MKPlacemark(placemark: pm)
                                            
                                            
                                            var mapItem = MKMapItem(placemark:mkPm)
                                            
                                            mapItem.name = self.name
                                            
                                            //You could also choose: MKLaunchOptionsDirectionsModeWalking
                                            var launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                                            
                                            mapItem.openInMapsWithLaunchOptions(launchOptions)
                                            
                                        } else {
                                            print("Problem with the data received from geocoder")
                                        }
                                    }
                                })
                                
                                
                                
                            }
                            
                            
                            
                        }
                        
                
                        
                        // print(object.objectId!)
                    }
                }
                
                
            }
    
    
    @IBAction func deleteAdress(sender: AnyObject) {
        
        
        var query = PFQuery(className:"AdressList")
        query.whereKey("title", equalTo: self.name)
        query.whereKey("note", equalTo: self.note)
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            if error == nil {
                
                for object in objects!  {
                    
                    object.deleteInBackground()
                }
                
                
                
            } else {
                print(error)
            }
        }
        

        
        navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    @IBAction func editAdress(sender: AnyObject) {
    }
    
    

}
