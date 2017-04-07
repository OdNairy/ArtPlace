//
//  MapInteractorTests.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import MapKit

@testable import ArtPlace

class MockStorage1 : ManagablePlaces {

    func getPlaces(callback: GetPlacesCallback) {
        callback(nil, [])
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        callback(nil, nil)
    }
}

class MockStorage2 : ManagablePlaces {

    
    func getPlaces(callback: GetPlacesCallback) {
        callback("Error Message", [])
    }
    
    func createArtPlace(title: String, comments: String, longitude: Double, latitude: Double, callback: CreateArtPlaceCallback) {
        callback("Error Message", nil)
    }
    
}

class MapInteractorTests: XCTestCase {
    
    let interactor = MapInteractor()
    let coordinate = CLLocationCoordinate2D()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreatePlace() {
        interactor.storage = MockStorage1()
        interactor.createPlace(coordinate: coordinate, callback: { errorMessage, place in
            //message is not nil if method throwed error
            XCTAssertNil(errorMessage)
        })
        
        interactor.storage = MockStorage2()
        interactor.createPlace(coordinate: coordinate, callback: { errorMessage, place in
            //message is  nil if method throwed error
            XCTAssertNotEqual(errorMessage, nil)
        })
    }
    
    func testGetPlacesAnnotations() {
        interactor.storage = MockStorage1()
        interactor.getPlacesAnnotations() { errorMessage, place in
            //message is not nil if method throwed error
            XCTAssertNil(errorMessage)
        }
        
        interactor.storage = MockStorage2()
        interactor.getPlacesAnnotations() { errorMessage, place in
            //message is  nil if method throwed error
            XCTAssertNotEqual(errorMessage, nil)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
