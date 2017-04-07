//
//  LocationProcessor.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreLocation

class LocationProcessor : NSObject, CLLocationManagerDelegate {
    
    static public let access = LocationProcessor()
    var userLocation: CLLocation? = nil
    
    private override init() {
        super.init()
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    class func distanceToCurLocation(coordinate: CLLocationCoordinate2D) -> Double {
        return (LocationProcessor.access.userLocation?.distance(from:
            CLLocation(latitude: coordinate.latitude,longitude: coordinate.longitude))) ?? 0
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        userLocation = locations[0] as? CLLocation
    }
    
}
