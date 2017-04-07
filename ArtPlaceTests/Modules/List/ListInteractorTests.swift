//
//  ListInteractorTests.swift
//  ArtPlace
//
//  Created by Ira on 4/7/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest

@testable import ArtPlace

class ListInteractorTests: XCTestCase {
    
    let interactor = ListInteractor()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPlacesAnnotations ()  {
        
        interactor.storage = MockStorage1()
        interactor.getPlacesAnnotations  { errorMessage, places in
            //message is not nil if method throwed error
            XCTAssertNil(errorMessage)
        }
        
        interactor.storage = MockStorage2()
        interactor.getPlacesAnnotations  { errorMessage, places in
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
