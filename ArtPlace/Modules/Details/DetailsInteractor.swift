//
//  DetailsInteractor.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation

class DetailsInteractor {
    
    func updateArtObject(artPlace : DetailsArtPlaceViewModel) {
        let arctPlaceModel =  Storage.access.persistentContainer.viewContext.object(with: artPlace.objetctID) as? ArtPlace
        arctPlaceModel?.title = artPlace.title
        arctPlaceModel?.comments = artPlace.comments
        Storage.access.saveContext()
    }
    
}
