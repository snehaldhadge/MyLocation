//
//  ViewController.swift
//  MyLocation
//
//  Created by Snehal Dhadge on 13/12/14.
//  Copyright (c) 2014 Snehal Dhadge. All rights reserved.
//



import UIKit
import CoreLocation


class ViewController: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet var gpsResult: UILabel!
    
   var manager:CLLocationManager!=nil
   // var locations:[AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        manager.requestAlwaysAuthorization()
       // self.manager.requestAlwaysAuthorization()
        // manager.locationServicesEnabled
    //    manager.startUpdatingLocation()
     //   locationManager(manager,didUpdateLocations: locations)
        println("Done")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    
    
    


    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            var shouldIAllow = false
            var locationStatus : NSString = "Not Started"
            switch status {
            case CLAuthorizationStatus.Restricted:
                locationStatus = "Restricted Access to location"
            case CLAuthorizationStatus.Denied:
                locationStatus = "User denied access to location"
            case CLAuthorizationStatus.NotDetermined:
                locationStatus = "Status not determined"
            default:
                locationStatus = "Allowed to location Access"
                shouldIAllow = true
            }
            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
            if (shouldIAllow == true) {
                NSLog("Location to Allowed")
                // Start location services
                manager.startUpdatingLocation()
            } else {
                println("Denied access: \(locationStatus)")
            }
            
            
            gpsResult.text = "success "
            
            //manager.startUpdatingLocation()
            
            
    }

        func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
                
                if (error != nil) {
                    println("Reverse geocoder failed with error \(error.localizedDescription)")
                    return
                }
                
                if placemarks.count > 0 {
                    let pm = placemarks[0] as CLPlacemark
                    self.displayLocationInfo(pm)
                } else {
                    println("Problem with the data received from geocoder")
                }
            })
        }
        func displayLocationInfo(placemark: CLPlacemark) {
            if placemark != 0 {
                //stop updating location to save battery life
                manager.stopUpdatingLocation()
                println("placemark.locality:\(placemark.locality)")
                println("placemark.postalCode:\(placemark.postalCode)")
                println("placemark.administrativeArea: \(placemark.administrativeArea)")
                println("placemark.country:\(placemark.country)")
            }
        }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




