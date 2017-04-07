//
//  ListInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

typealias GetListPlacesCallback = (_ errorMessage: String?, _ place: [ListArtPlaceViewModel]?) -> (Void)

class ListInteractor {
    
    var storage : ManagablePlaces = Storage.access
    
    func getPlacesAnnotations (callback : GetListPlacesCallback) {
        var placeAnnotaions : [ListArtPlaceViewModel] = []
        storage.getPlaces { (errorMessage, placeMOs) -> (Void) in
            if let message = errorMessage {
                callback(message, nil)
            } else {
                for placeMO in placeMOs {
                    let place = ListArtPlaceViewModel(
                        objetctID:  placeMO.objectID,
                        title: placeMO.title ?? "",
                        comments: placeMO.comments ?? "",
                        coordinate: CLLocationCoordinate2D(latitude: placeMO.latitude, longitude: placeMO.longitude))
                    placeAnnotaions.append(place)
                }

                placeAnnotaions.sort(by: {
                    LocationProcessor.distanceToCurLocation(coordinate: $0.coordinate)  <
                    LocationProcessor.distanceToCurLocation(coordinate: $1.coordinate) })
                callback(nil, placeAnnotaions)
            } 
        }
    }
    
    
}
