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
    case count
}

class NASAViewModel {
    
    // MARK: Properties
    
    private let roverPhotos: RoverPhotos
    
    // MARK: - Initializers
    
    init(roverPhotos: RoverPhotos = RoverPhotos()) {
        self.roverPhotos = roverPhotos
    }
}

