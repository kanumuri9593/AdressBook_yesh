//
//  AdressListViewController.swift
//  AdressBook
//
//  Created by Yeswanth varma Kanumuri on 1/21/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class AdressListViewController: UITableViewController {
    
    
    var locations = [CLLocationCoordinate2D]()
    
    var name = [String]()
    var note = [String]()
    var adress1 = [String]()
    var adress2 = [String]()
    var city = [String]()
    var pin = [String]()
    var tiles = [adress]()
    var arange = [adress]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.reloadData()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.name.removeAll()
        self.note.removeAll()
        self.adress1.removeAll()
        self.adress2.removeAll()
        self.city.removeAll()
        self.pin.removeAll()
        self.tiles.removeAll()
        
        
        let query = PFQuery(className:"AdressList")
        query.whereKey("username", equalTo:PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            
            if error == nil {
                
                
                if let objects = objects {
                    
                    
                    
                    for object in objects {
                        
                        if let object:PFObject = object {
                            
                            
                            
                            
                            
                            if object["title"] != nil {
                                
                                if let username = object["title"] as? String {
                                    
                                    self.name.append(username)
                                    
                                    
                                    
                                }
                                
                                
                                if let note = object["note"] as? String {
                                    
                                    self.note.append(note)
                                    
                                    
                                    
                                }
                                
                                if let ad1 = object["Adressline1"] as? String {
                                    
                                    self.adress1.append(ad1)
                                    
                                    
                                    
                                }
                                if let ad2 = object["Adressline2"] as? String {
                                    
                                    self.adress2.append(ad2)
                                    
                                    
                                    
                                }
                                
                                if let city = object["city"] as? String {
                                    
                                    self.city.append(city)
                                    
                                    
                                    
                                }
                                
                                if let pin = object["Pin"] as? String {
                                    
                                    self.pin.append(pin)
                                    
                                    
                                    
                                }else {
                                    
                                    let pinn = ""
                                    
                                    self.pin.append(pinn)
                                    
                                }
                                
                                
                                if let loc = object["location"] as? PFGeoPoint {
                                    
                                    let requestLocation =  CLLocationCoordinate2DMake(loc.latitude, loc.longitude)
                                    
                                    self.locations.append(requestLocation)
                                    
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            let name = object["title"]
                            let note = object["note"]
                            
                            
                            
                            
                            
                            let post = adress(title: name as! String, note: note as! String)
                            print(post)
                            self.tiles.append(post)
                            self.tiles.sortInPlace({ (adress1, adress2) -> Bool in
                                
                                adress1.title < adress2.title
                                
                                
                            })
                            
                            
                        }
                    }
                    
                    
                    
                    
                    self.tableView.reloadData()
                    
                }
                
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return name.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! AdressListTableViewCell
        
        
        
        var post : adress!
        
        post = self.tiles[indexPath.row]
        
        cell.configCell(post)
        
        return cell
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "logout" {
            
            navigationController?.setNavigationBarHidden(true, animated: false)
            
            PFUser.logOut()
            
            
        } else if segue.identifier == "addAdress" {
            
            _ = segue.destinationViewController as? AddAdressViewController
            
            
        } else {
            
            let destination = segue.destinationViewController as? NavigateViewController
            
            
            
            
            
            destination?.name = name[(tableView.indexPathForSelectedRow?.row)!]
            destination?.note = note[(tableView.indexPathForSelectedRow?.row)!]
            destination?.adress1 = adress1[(tableView.indexPathForSelectedRow?.row)!]
            destination?.adress2 = adress2[(tableView.indexPathForSelectedRow?.row)!]
            destination?.city = city[(tableView.indexPathForSelectedRow?.row)!]
            destination?.pin = pin[(tableView.indexPathForSelectedRow?.row)!]
            destination?.requestLocation = locations[(tableView.indexPathForSelectedRow?.row)!]
            
            
            
        }
        
    }
    
  //fully functional with sorted list
    
}
