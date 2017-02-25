//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Christopher Bonuel on 2/24/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import XCTest
@testable import NASApp

class NASAppTests: XCTestCase {
    
    var nasaViewModel: NASAViewModel!
    var apodPhotos: APODPhotos!
    var roverPhotos: RoverPhotos!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apodPhotos = APODPhotos()
        roverPhotos = RoverPhotos()
        nasaViewModel = NASAViewModel(apodPhotos: apodPhotos, roverPhotos: roverPhotos)
    }
    
    override func tearDown() {
        nasaViewModel = nil
        apodPhotos = nil
        roverPhotos = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(nasaViewModel.numberOfSections, 2)
    }
    
    func testInitialScrollViewIndices() {
        XCTAssertEqual(nasaViewModel.scrollViewIndices, [2, 1, 0])
    }
    
    func testScrollLeftAndRight() {
        nasaViewModel.scrollViewDidScroll(toPage: .left)
        XCTAssertEqual(apodPhotos.numberOfDaysBeforeToday, [3, 2, 1])
        nasaViewModel.scrollViewDidScroll(toPage: .right)
        XCTAssertEqual(apodPhotos.numberOfDaysBeforeToday, [2, 1, 0])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
