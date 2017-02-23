//
//  APODPhotos.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/19/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

class APODPhotos {
    
    // MARK: - Properties
    
    var urls = [String : URL]()
    
    private func fetchPhotoURL(from date: Date? = nil) {
        
        let dateString = date?.yyyyMMdd(withSeparator: "-") ?? Date().yyyyMMdd(withSeparator: "-")
        
        if urls[dateString] != nil {
            // url for this date is already cached
            return
        }
        
        let provider = MoyaProvider<MyService>()
        provider.request(.apod(date: date)) { result in
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200:
                    let json = JSON(data: response.data)
                    let urlString = json["url"].stringValue
                    let url = URL(string: urlString)!
                    
                    self.urls[urlString] = url
                    self.urls[dateString] = url
                default:
                    print("Received HTTP response: \(response.statusCode), which was not handled")
                }
            case let .failure(error):
                print("Error not handled: \(error)")
            }
        }
    }
}
