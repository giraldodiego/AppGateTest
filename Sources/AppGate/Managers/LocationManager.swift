//
//  LocationManager.swift
//  
//
//  Created by Diego Giraldo Gómez on 25/04/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getLocation() -> CLLocationCoordinate2D? {
        if let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate {
            return locValue
        }
        return nil
    }
}
