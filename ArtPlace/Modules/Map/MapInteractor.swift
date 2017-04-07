//
//  MapInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

typealias CreatePlaceCallback = (_ errorMessage: String?, _ place: ArtPlaceAnnotation?) -> (Void)
typealias GetPlacesAnnotationsCallback = (_ errorMessage: String?, _ annotations: [ArtPlaceAnnotation]?) -> (Void)

class MapInteractor {
    
    var storage : ManagablePlaces = Storage.access
    
    func getPlacesAnnotations (callback: GetPlacesAnnotationsCallback) {
        var placeAnnotaions : [ArtPlaceAnnotation] = []
        storage.getPlaces { (errorMessage, placeMOs) -> (Void) in
            if let message = errorMessage {
                callback(message, nil)
            } else {
                for placeMO in placeMOs {
                    let place = ArtPlaceAnnotation(title: placeMO.title ?? "",
                                                   comments: placeMO.comments ?? "",
                                                   longitude: placeMO.longitude,
                                                   latitude: placeMO.latitude,
                                                   objetctID: placeMO.objectID)
                    placeAnnotaions.append(place)
                }
                callback(nil, placeAnnotaions)
            }
        }
    }
    
    func createPlace(coordinate: CLLocationCoordinate2D, callback: CreatePlaceCallback) {
        storage.createArtPlace(title: "New Place", comments: "",
                                      longitude: coordinate.longitude,  latitude: coordinate.latitude,
                                      callback:
            { message, place in
                if let errorMessage = message {
                    callback(errorMessage, nil)
                } else {
                    guard let artPlace = place
                        else { return}
                    let newPin = ArtPlaceAnnotation(title: artPlace.title ?? "",
                                                    comments: artPlace.comments ?? "",
                                                    longitude: artPlace.longitude,
                                                    latitude: artPlace.latitude,
                                                    objetctID: artPlace.objectID)
                    callback(nil, newPin)
                }
        })
    }
    
}
