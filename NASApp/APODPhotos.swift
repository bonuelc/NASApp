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
    var updateReceiver: UpdateReceiverType?
    
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
                    
                    let videoPlaceholderURLString = "https://www.eig88.com/wp-content/uploads/2016/11/video-player-placeholder-very-large.png"
                    let urlString = json["media_type"].stringValue == "image" ? json["url"].stringValue : videoPlaceholderURLString
                    let url = URL(string: urlString)!
                    
                    self.urls[urlString] = url
                    self.urls[dateString] = url
                case 400:
                    // date is out of APOD range
                    let urlString = "http://dlmjconstruction.com/wp-content/uploads/2015/08/placeholder-Copy-4-1024x769.png"
                    let url = URL(string: urlString)
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
