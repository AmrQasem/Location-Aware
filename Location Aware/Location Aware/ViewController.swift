//
//  ViewController.swift
//  Location Aware
//
//  Created by Clicks Egypt on 12/14/19.
//  Copyright © 2019 Clicks Egypt. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtiudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var nearestLocationLabel: UILabel!
    
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        self.latitudeLabel.text = String(location.coordinate.latitude)
        
        self.longtiudeLabel.text = String(location.coordinate.longitude)
        
        self.courseLabel.text = String(location.course)
        
        self.speedLabel.text = String(location.speed)
        
        self.altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil{
                
                print(error)
            }
            else{
                if let placemark = placemarks?[0]{
                    
                    var address = ""
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    if placemark.thoroughfare != nil{
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil{
                        address += placemark.subLocality! + "\n"
                    }
                    if placemark.subAdministrativeArea != nil{
                        address += placemark.subAdministrativeArea! + "\n"
                    }
                    if placemark.postalCode != nil{
                        address += placemark.postalCode! + "\n"
                    }
                    if placemark.country != nil{
                        address += placemark.country! + "\n"
                    }
                    self.nearestLocationLabel.text = address
                }
                
            }
        }
        
    }


}

