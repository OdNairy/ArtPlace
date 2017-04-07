//
//  ArtPlace+Model.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreData

extension ArtPlace {
    
    class func create(title: String, comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        let managedContext = Storage.access.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: String.classToString(ArtPlace.self), in: managedContext)!
        let artPlace = NSManagedObject(entity: entity, insertInto: managedContext) as! ArtPlace
        artPlace.title = title
        artPlace.comments = comments
        artPlace.latitude = latitude
        artPlace.longitude = longitude
        try managedContext.save()
        return artPlace
    }
    
    class func create(jsonPlace : [String: Any]) {
        if let title = jsonPlace["name"] as? String,
            let lng = jsonPlace["lng"] as? Double,
            let lat = jsonPlace["lat"] as? Double {
            try? ArtPlace.create(title: title, comments: "", longitude: lng, latitude: lat)
        } else {
            print("Invalid place format")
        }
    }
    
    class func getAll()  throws -> [ArtPlace] {
        let managedContext = Storage.access.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String.classToString(ArtPlace.self))
        return try managedContext.fetch(fetchRequest as! NSFetchRequest<ArtPlace>)
    }
    
}
