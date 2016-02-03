//
//  AddAdressViewController.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit
import Parse
import CoreLocation

class AddAdressViewController: UIViewController, CLLocationManagerDelegate ,MKMapViewDelegate, UITextFieldDelegate {
    
    
    
    var locationManager:CLLocationManager!
    
    var latitude :CLLocationDegrees = 0
    var longitude :CLLocationDegrees = 0
    
    var currentLocation: String = "Edit the location details"
    
    
    var editMode:Int = 1
    
    
    
    
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var currentAdress: UILabel!
    
    @IBOutlet weak var nameTitle: materialTextfield!
    
    @IBOutlet weak var note: materialTextfield!

    @IBOutlet weak var adress1: materialTextfield!
    
    @IBOutlet weak var adress2: materialTextfield!
    
    @IBOutlet weak var city: materialTextfield!
    
    @IBOutlet weak var pin: materialTextfield!
    
    
    @IBOutlet weak var addadressLbl: materialButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        if editMode == 2 {
        
        self.addadressLbl.setTitle("Update Adress", forState: UIControlState.Normal)
        
        } else {
        
        self.addadressLbl.setTitle("Add Adress", forState: UIControlState.Normal)
        
        
        }


        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location:CLLocationCoordinate2D = manager.location!.coordinate
        
       
        
        if editMode == 1 {
        self.latitude = location.latitude
        self.longitude = location.longitude
        }
        
      
        
        let center = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        self.map.removeAnnotations(map.annotations)
        
        let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "Your location"
        
        
        
        
        //--- CLGeocode to get address of current location ---//
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil)
            {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0
            {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
                
                self.editMode = 1
                
            }
            else
            {
                print("Problem with the data received from geocoder")
            }
        })

        self.map.addAnnotation(objectAnnotation)
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark?)
    {
        if let containsPlacemark = placemark
        {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality! : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode! : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea! : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country! : ""
            
            
            
            let currenGpsAdress : String = "Current Location : \(locality), \(administrativeArea), \(postalCode),\(country)."
            
          
            
            if editMode == 1 {
            
            self.currentAdress.text = currenGpsAdress
            
            }else {
            
            
            self.currentAdress.text = "update the current location"
            
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    @IBAction func addAdress(sender: AnyObject) {
        
        
        let riderRequest = PFObject(className:"AdressList")
        
        
        
        
        riderRequest["username"] = PFUser.currentUser()?.username
        riderRequest["location"] = PFGeoPoint(latitude:latitude, longitude:longitude)
        
        riderRequest["title"]    = self.nameTitle.text
        

            riderRequest["note"] = self.note.text
        riderRequest["Adressline1"] = self.adress1.text
        riderRequest["Adressline2"] = self.adress2.text
        riderRequest["city"]   = self.city.text
        riderRequest["Pin"]  = self.pin.text
        
        
        if self.nameTitle.text != "" {
        
        riderRequest.saveInBackground()
        
        
        navigationController?.popToRootViewControllerAnimated(true)
        
        
        
        }else if editMode == 2 {
        
            alert("Error", message: "please fill the fields")

        
        
        }else{
        
        alert("Error", message: "please enter a Name/Title.")
        
        }

         }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAdressList" {
            
            let destination = segue.destinationViewController as? AdressListViewController
            
            destination?.tableView.reloadData()
            
        }

        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
        
        
    }
    
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        let userInfo: [NSObject : AnyObject] = sender.userInfo!
        
        let keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
        let offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size
        
        if keyboardSize.height == offset.height {
            if self.view.frame.origin.y == 0 {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.view.frame.origin.y -= keyboardSize.height
                })
            }
        } else {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.view.frame.origin.y += keyboardSize.height - offset.height
            })
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }

    
    
    func alert (title :String! , message :String!) {
        
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            
            
            print("Alert view not available")
            // Fallback on earlier versions
        }
        
    }
    
}
    






