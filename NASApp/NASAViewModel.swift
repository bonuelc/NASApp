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
    case astronomyPictureOfTheDay
    
    static var count = {
        return NASASection.COUNT.rawValue
    }()
}

class NASAViewModel: UpdateReceiverType {
    
    // MARK: Properties
    
    private let apodPhotos: APODPhotos
    private let roverPhotos: RoverPhotos
    var updateReceiver: UpdateReceiverType?
    
    // MARK: - Initializers
    
    init(apodPhotos: APODPhotos = APODPhotos(), roverPhotos: RoverPhotos = RoverPhotos()) {
        
        self.apodPhotos = apodPhotos
        self.roverPhotos = roverPhotos
        
        self.apodPhotos.updateReceiver = self
        self.roverPhotos.updateReceiver = self
    }
        
    var numberOfSections: Int {
        return NASASection.count
    }
    
    func numberOfPhotos(inSection section: Int) -> Int {
        
        guard let nasaSection = NASASection(rawValue: section) else { fatalError() }
        
        switch nasaSection {
        case .astronomyPictureOfTheDay: return 1
        case .marsRoverImagery: return roverPhotos.count
        default: return 0
        }
    }
    
    func photoURL(at indexPath: IndexPath) -> URL {
        
        guard let nasaSection = NASASection(rawValue: indexPath.section) else { fatalError() }
        
        switch nasaSection {
        case .astronomyPictureOfTheDay:
            return URL(string: "https://apod.nasa.gov/apod/image/1701/pandora_cassini_960.jpg")! // TODO: replace stubbed data
        case .marsRoverImagery: return roverPhotos[indexPath.row]
        default: fatalError()
        }
    }
    
    func didUpdateModel() {
        updateReceiver?.didUpdateModel()
    }
}

