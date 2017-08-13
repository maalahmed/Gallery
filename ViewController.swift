//
//  ViewController.swift
//  Gallery
//
//  Created by Mohamed Al Ahmed on 8/10/17.
//  Copyright © 2017 Gallery. All rights reserved.
//

import UIKit
///import library for location
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {

    //used to start getting the users location
    let locationManager = CLLocationManager()
    
    var latet: Double = 0
    var longet: Double = 0
    
    
    
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
                        print(location.coordinate)
            print(location.coordinate.latitude)
            latet = Double(location.coordinate.latitude)
            longet = location.coordinate.longitude
            ///START get city and country names///
            
            
            let location = CLLocation(latitude: latet , longitude: longet)
            
            fetchCountryAndCity(location: location) { country, city in
                print("country:", country)
                print("city:", city)
            }
            print("end")
            
            
            ////END get city and country name ////
            if String(location.coordinate.latitude) != "" {
                locationManager.stopUpdatingLocation()
            }
            
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
        

        
    }
    
    
    ////function for city and country
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                completion(country, city)
            }
        }
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //////Start getting location process//////
        
        // For use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
         
            
          
        }
        
        print(latet)
        print(longet)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

