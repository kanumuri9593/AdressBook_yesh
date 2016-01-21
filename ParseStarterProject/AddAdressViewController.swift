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
    
    var currentLocation: String = ""
    
    
    
    
    
    
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

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.latitude = location.latitude
        self.longitude = location.longitude
        
        print("locations = \(location.latitude) \(location.longitude)")
        
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        
        self.map.removeAnnotations(map.annotations)
        
        var pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        var objectAnnotation = MKPointAnnotation()
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
            
            print(locality)
            print(postalCode)
            print(administrativeArea)
            print(country)
            
            let currenGpsAdress : String = "Current Location : \(locality), \(administrativeArea), \(postalCode),\(country)."
            
            print(currenGpsAdress)
            
            self.currentAdress.text = currenGpsAdress
            
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    
    
}
    






