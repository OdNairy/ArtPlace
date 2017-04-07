//
//  String+extensionTests.swift
//  ArtPlace
//
//  Created by Ira on 4/6/17.
//  Copyright © 2017 Ira. All rights reserved.
//

import XCTest
import CoreData

@testable import ArtPlace

class String_extensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVariousClasses() {
        XCTAssertEqual(String.classToString(NSManagedObject.self), "NSManagedObject")
        XCTAssertEqual(String.classToString(ArtPlace.self), "ArtPlace")
        XCTAssertEqual(String.classToString(AppDelegate.self), "AppDelegate")
        XCTAssertEqual(String.classToString(UIViewController.self), "UIViewController")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
