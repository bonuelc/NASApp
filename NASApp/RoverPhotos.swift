//
//  RoverPhotos.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation

class RoverPhotos {
    
    // MARK: - Properties
    
    fileprivate var photoURLs = [URL]()
    
    var count: Int {
        return photoURLs.count
    }
}

// MARK: - Helper Methods

extension RoverPhotos {
    
    subscript(index: Int) -> URL {
        return photoURLs[index]
    }
}
