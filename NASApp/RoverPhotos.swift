//
//  RoverPhotos.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/8/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class RoverPhotos {
    
    // MARK: - Properties
    
    fileprivate var photoURLs = [URL]() {
        didSet {
            updateReceiver?.didUpdateModel()
        }
    }
    var updateReceiver: UpdateReceiverType?
    
    var count: Int {
        return photoURLs.count
    }
    
    // MARK: - Initializers
    
    init() {
        fetchPhotoURLs(from: .curiosity)
    }
    
    private func fetchPhotoURLs(from rover: MyService) {
        let provider = MoyaProvider<MyService>()
        provider.request(rover) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    let json = JSON(data: response.data)
                    self.photoURLs = json["photos"].arrayValue.flatMap{ URL(string: $0["img_src"].stringValue) }
                default:
                    print("Received HTTP response: \(response.statusCode), which was not handled")
                }
            case let .failure(error):
                print("Error not handled: \(error)")
            }
        }
    }
}

// MARK: - Helper Methods

extension RoverPhotos {
    
    subscript(index: Int) -> URL {
        return photoURLs[index]
    }
}
