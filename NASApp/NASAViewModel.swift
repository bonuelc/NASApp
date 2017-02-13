//
//  NASAViewModel.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation

enum NASASection: Int {
    case marsRoverImagery
    case COUNT
    
    static var count = {
        return NASASection.COUNT.rawValue
    }()
}

class NASAViewModel {
    
    // MARK: Properties
    
    private let roverPhotos: RoverPhotos
    
    // MARK: - Initializers
    
    init(roverPhotos: RoverPhotos = RoverPhotos()) {
        self.roverPhotos = roverPhotos
    }
        
    var numberOfSections: Int {
        return NASASection.count
    }
}

