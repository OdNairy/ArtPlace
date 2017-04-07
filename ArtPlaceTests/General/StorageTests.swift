//
//  StorageTests.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest

@testable import ArtPlace

class ArtPlaceMock1 : ArtPlace {
    
    enum MockError : Error {
        case MockError(String)
    }
    
    override class func getAll()  throws -> [ArtPlace] {
        throw MockError.MockError("test")
    }
    
    override class func create(jsonPlace : [String: Any]) {
    }
    
    override class func create(title: String, comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        throw MockError.MockError("test")
    }
    
}

class ArtPlaceMock2 : ArtPlace {
    
    enum MockError : Error {
        case MockError(String)
    }
    
    override class func getAll()  throws -> [ArtPlace] {
        return []
    }
    
    override class func create(jsonPlace : [String: Any]) { }
    
    override class func create(title: String,  comments: String, longitude: Double, latitude: Double) throws -> ArtPlace {
        return ArtPlaceMock2()
    }
    
}

class StorageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPlaces() {
        Storage.access.artPlaceClass = ArtPlaceMock1.self
        Storage.access.getPlaces { (errorMessage, places) -> (Void) in
            //message is not nil if method throwed error
            XCTAssertNotEqual(errorMessage, nil)
            XCTAssertEqual(places.count, 0)
        }
        Storage.access.artPlaceClass = ArtPlaceMock2.self
        Storage.access.getPlaces { (errorMessage, places) -> (Void) in
            //message is  nil if method throwed error
            XCTAssertEqual(errorMessage, nil)
            XCTAssertEqual(places.count, 0)
        }
    
    }
    
    func testCreateArtPlace() {
        
        Storage.access.artPlaceClass = ArtPlaceMock1.self
        Storage.access.createArtPlace(title: "", comments: "", longitude: 0, latitude: 0,
                                      callback: { (errorMessage, place) -> (Void) in
            //message is not nil if method throwed error
            XCTAssertNotEqual(errorMessage, nil)
        })
        
        Storage.access.artPlaceClass = ArtPlaceMock2.self
        Storage.access.createArtPlace(title: "", comments: "", longitude: 0, latitude: 0,
                                      callback: { (errorMessage, place) -> (Void) in
            //message is  nil if method throwed error
            XCTAssertNil(errorMessage)
        })
        
    }
    
    func testLoadDefaultPlaces() {
        //load all 2 locations
        let locs1 = Storage.access.loadDefaultPlaces(filename: "locations1", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs1.count, 2)
        //ignore wrong json
        let locs3 = Storage.access.loadDefaultPlaces(filename: "locations3", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs3.count, 0)
        //ignore invalid json
        let locs4 = Storage.access.loadDefaultPlaces(filename: "locations4", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs4.count, 0)
        //ignore not existing file
        let locs5 = Storage.access.loadDefaultPlaces(filename: "locations5", bundle: Bundle(for: type(of: self)))
        XCTAssertEqual(locs5.count, 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
