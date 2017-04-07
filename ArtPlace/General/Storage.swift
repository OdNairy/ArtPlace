//
//  Storage.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import Foundation
import CoreData

typealias GetPlacesCallback = (_ errorMessage: String?,  _ places: [ArtPlace]) -> (Void)
typealias CreateArtPlaceCallback = (_ errorMessage: String?, _ place: ArtPlace?) -> (Void)

protocol ManagablePlaces {
    func getPlaces(callback: GetPlacesCallback)
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback)
}

class Storage : ManagablePlaces {
    
    public static let access = Storage();
    
    let delfaultLocationsFile = "locations"
    let locationsLoadedFlag = "fileLoaded"
    var artPlaceClass = ArtPlace.self
    
    private init(){
        
    }
    
    func getPlaces(callback: GetPlacesCallback) {
        if !UserDefaults.standard.bool(forKey: locationsLoadedFlag) {
            for jsonPlace in loadDefaultPlaces(filename: delfaultLocationsFile, bundle: Bundle.main) {
                artPlaceClass.create(jsonPlace: jsonPlace)
            }
            UserDefaults.standard.set(true, forKey: locationsLoadedFlag)
        }
        if let places = try?  artPlaceClass.getAll() {
            callback(nil, places)
        } else {
            callback("Can't get Art Places", [])
        }
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        do {
           let place = try artPlaceClass.create(title: title, comments: comments, longitude: longitude, latitude: latitude)
            callback(nil, place)
        } catch let error as NSError {
            callback(error.localizedDescription, nil)
        }
    }
    
    func loadDefaultPlaces(filename: String, bundle : Bundle) -> [[String: Any]] {
        if let file = bundle.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: file),
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonPlaces = (json as? [String: Any])?["locations"] as? [[String: Any]] {
            return jsonPlaces
        } else {
            print("Invalid file or format")
            return []
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ArtPlace")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
}
