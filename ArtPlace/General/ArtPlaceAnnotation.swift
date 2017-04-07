//
//  ArtPlaceAnnotation.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import MapKit
import CoreData

class ArtPlaceAnnotation : NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title : String?
    let comments : String
    let objetctID : NSManagedObjectID
    
    init(title: String, comments: String, longitude: Double, latitude: Double, objetctID: NSManagedObjectID) {
        self.title = title
        self.comments = comments
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.objetctID = objetctID
        super.init()
    }

}
