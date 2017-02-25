//
//  NASAppTests.swift
//  NASAppTests
//
//  Created by Christopher Bonuel on 2/24/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import XCTest
@testable import NASApp
import Moya

class NASAppTests: XCTestCase {
    
    var nasaViewModel: NASAViewModel!
    var apodPhotos: APODPhotos!
    var roverPhotos: RoverPhotos!
    var mockProvider: MoyaProvider<MyService>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockProvider = MoyaProvider(stubClosure: MoyaProvider.immediatelyStub)
        apodPhotos = APODPhotos(provider: mockProvider)
        roverPhotos = RoverPhotos(provider: mockProvider)
        nasaViewModel = NASAViewModel(apodPhotos: apodPhotos, roverPhotos: roverPhotos)
    }
    
    override func tearDown() {
        nasaViewModel = nil
        apodPhotos = nil
        roverPhotos = nil
        mockProvider = nil
        
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
    
    func testScrollToRightPageFromStart() {
        nasaViewModel.scrollViewDidScroll(toPage: .right)
        XCTAssertEqual(apodPhotos.numberOfDaysBeforeToday, [2, 1, 0])
    }
    
    func testRoverPhotosJSONParse() {
        XCTAssertEqual(roverPhotos[0].absoluteString, "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
