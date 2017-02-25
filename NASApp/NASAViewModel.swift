//
//  NASAViewModel.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation

enum NASASection: Int {
    case astronomyPictureOfTheDay
    case marsRoverImagery
    case COUNT
    
    static var count = {
        return NASASection.COUNT.rawValue
    }()
}

class NASAViewModel: UpdateReceiverType {
    
    // MARK: Properties
    
    private let apodPhotos: APODPhotos?
    private let roverPhotos: RoverPhotos?
    var updateReceiver: UpdateReceiverType?
    
    var scrollViewIndices: [Int] {
        return apodPhotos!.numberOfDaysBeforeToday
    }
    
    var todaysImage: URL? {
        return apodPhotos?.photoURL(fromNumberOfDaysBeforeToday: 0)
    }
    
    // MARK: - Initializers
    
    init(apodPhotos: APODPhotos? = APODPhotos(), roverPhotos: RoverPhotos? = RoverPhotos()) {
        
        self.apodPhotos = apodPhotos
        self.roverPhotos = roverPhotos
        
        self.apodPhotos?.updateReceiver = self
        self.roverPhotos?.updateReceiver = self
    }
        
    var numberOfSections: Int {
        return NASASection.count
    }
    
    func numberOfPhotos(inSection section: Int) -> Int {
        
        guard let nasaSection = NASASection(rawValue: section) else { fatalError() }
        
        switch nasaSection {
        case .astronomyPictureOfTheDay: return apodPhotos == nil ? 0 : 1
        case .marsRoverImagery: return roverPhotos?.count ?? 0
        default: return 0
        }
    }
    
    func photoURL(at indexPath: IndexPath) -> URL? {
        
        guard let nasaSection = NASASection(rawValue: indexPath.section) else { fatalError() }
        
        switch nasaSection {
        case .astronomyPictureOfTheDay: return apodPhotos?.photoURL(fromNumberOfDaysBeforeToday: indexPath.row)
        case .marsRoverImagery: return roverPhotos?[indexPath.row]
        default: fatalError()
        }
    }
    
    func scrollViewDidScroll(toPage page: Page) {
        switch page {
        case .left: apodPhotos?.shiftOneDay(.backward)
        case .center: break
        case .right: apodPhotos?.shiftOneDay(.forward)
        }
    }
    
    func didUpdateModel() {
        updateReceiver?.didUpdateModel()
    }
}
