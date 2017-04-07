//
//  MapHelper.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import MapKit

class MapHelper : NSObject, MKMapViewDelegate {
    
    let interactor = MapInteractor()
    private let annotationIdentifier = "ArtPlacePin"
    
    var contoller : MapController? {
        didSet {
            contoller?.placesMap.delegate = self
        }
    }
    
    func handleLongPress(_ getstureRecognizer : UIGestureRecognizer){
        if getstureRecognizer.state != .began { return }
        
        let touchPoint = getstureRecognizer.location(in: contoller?.placesMap)
        let touchMapCoordinate = contoller?.placesMap.convert(touchPoint, toCoordinateFrom: contoller?.placesMap)
        
        interactor.createPlace(coordinate: touchMapCoordinate!, callback: { errorMessage, newPin in
            if let message = errorMessage {
                contoller?.showErrorAllert(message: message)
            } else {
                if let pin = newPin {
                    contoller?.addAnnotation(annotation: pin)
                }
            }
            
        })
        
    }
    
    func setupInitialMap() {
        interactor.getPlacesAnnotations(callback : { errorMessage, annotations in
            if let message = errorMessage {
                contoller?.showErrorAllert(message: message)
            } else {
                contoller?.addAnnotations(annotations: annotations ?? [])
            }
        })
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ArtPlaceAnnotation {
            let view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
                view.canShowCallout = true
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        return nil
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsStoryboard") as! DetailsController
        if let annotation = view.annotation as? ArtPlaceAnnotation  {
            let detailsArtPlaceViewModel = DetailsArtPlaceViewModel(
                objetctID : annotation.objetctID,
                title : annotation.title ?? "",
                comments : annotation.comments,
                coordinate : annotation.coordinate)
            vc.artPlace = detailsArtPlaceViewModel
            contoller?.tabBarController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
