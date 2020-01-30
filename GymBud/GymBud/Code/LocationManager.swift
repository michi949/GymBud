//
//  LocationManager.swift
//  GymBud
//
//  Created by Reder on 21.01.20.
//  Copyright © 2020 Reder. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    var location:CLLocationCoordinate2D!
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    ///Handle an change of location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let tmpLoc: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.location = tmpLoc
    }
    
    ///Check for postion and
    /// - returns: The loaction string.
    func getLocationInString() -> String {
        let pos = self.getLocationValue()
        return "\(String(format: "%.3f", pos.lat)) / \(String(format: "%.3f", pos.long))"
    }
    
    /// - returns: The coordinates.
    func getLocationValue() -> (lat: Double, long: Double) {
        if location != nil {
            return (Double(location.latitude), Double(location.longitude))
        } else {
            return (0,0)
        }
    }
    
    func getLocationRegion() -> MKCoordinateRegion? {
        
        if location != nil {
            return MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
        return nil 
    }
    
    func getLocation() -> CLLocationCoordinate2D {
        return self.location
    }
}
