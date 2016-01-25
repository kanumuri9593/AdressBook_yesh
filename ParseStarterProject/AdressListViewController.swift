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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.reloadData()
        
        
    }

    override func viewDidAppear(animated: Bool) {
        
        self.name.removeAll()
        self.note.removeAll()
        
        var query = PFQuery(className:"AdressList")
        query.whereKey("username", equalTo:PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock {
            (objects, error) -> Void in
            
            if error == nil {
                
                
                
                //print("Successfully retrieved \(objects!) .")
                
                // Do something with the found objects
                if let objects = objects {
                    
                    
                    
                    for object in objects {
                        
                        if let object:PFObject = object as! PFObject{
                            
                            
                            print(object["username"])
                            
                            
                            if object["title"] != nil {
                                
                                if let username = object["title"] as? String {
                                    
                                    self.name.append(username)
                                    
                                    print(self.name)
                                    
                                }
                                
                                
                                if let note = object["note"] as? String {
                                    
                                    self.note.append(note)
                                    
                                    print(self.note)
                                    
                                }
                                
                                if let ad1 = object["Adressline1"] as? String {
                                    
                                    self.adress1.append(ad1)
                                    
                                    print(self.adress1)
                                    
                                }
                                if let ad2 = object["Adressline2"] as? String {
                                    
                                    self.adress2.append(ad2)
                                    
                                    //print(self.note)
                                    
                                }
                                
                                if let city = object["city"] as? String {
                                    
                                    self.city.append(city)
                                    
                                    print(self.note)
                                    
                                }
                                
                                if let pin = object["Pin"] as? String {
                                    
                                    self.pin.append(pin)
                                    
                                    print(self.pin)
                                    
                                }else {
                                
                                let pinn = ""
                                    
                                    self.pin.append(pinn)
                                
                                }
                                
                                
                                if let loc = object["location"] as? PFGeoPoint {
                                    
                                    let requestLocation =  CLLocationCoordinate2DMake(loc.latitude, loc.longitude)
                                    
                                    self.locations.append(requestLocation)
                                    
                                    print(self.locations)
                                    
                                }
                                
                                
                          
                            }
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return name.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! AdressListTableViewCell
        
        let tile = adress(title: self.name[indexPath.row], note: self.note[indexPath.row])

        cell.configCell(tile)

        return cell
    }
    


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "logout" {
            
            navigationController?.setNavigationBarHidden(true, animated: false)
            
            PFUser.logOut()
            
            
        } else if segue.identifier == "addAdress" {
            
            let destination = segue.destinationViewController as? AddAdressViewController
            
            
        } else {
        
         let destination = segue.destinationViewController as? NavigateViewController
            
            print(pin.count)
            //print(pin[(tableView.indexPathForSelectedRow?.row)!])
            
           // self.tableView.reloadData()
            
        
            destination?.name = name[(tableView.indexPathForSelectedRow?.row)!]
            destination?.note = note[(tableView.indexPathForSelectedRow?.row)!]
            destination?.adress1 = adress1[(tableView.indexPathForSelectedRow?.row)!]
            destination?.adress2 = adress2[(tableView.indexPathForSelectedRow?.row)!]
            destination?.city = city[(tableView.indexPathForSelectedRow?.row)!]
            destination?.pin = pin[(tableView.indexPathForSelectedRow?.row)!]
            destination?.requestLocation = locations[(tableView.indexPathForSelectedRow?.row)!]
            
            print(name[(tableView.indexPathForSelectedRow?.row)!])
            print(adress1[(tableView.indexPathForSelectedRow?.row)!])
            print(city[(tableView.indexPathForSelectedRow?.row)!])
            
        
        }

    }
    
    
    
}
