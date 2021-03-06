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

enum DateShift {
    case backward, forward
}

class APODPhotos {
    
    // MARK: - Properties
    
    var numberOfDaysBeforeToday = [2, 1, 0] { // 0 == today, 1 == yesterday, etc.
        didSet {
            updateReceiver?.didUpdateModel()
        }
    }
    var urls = [String : URL]()
    var updateReceiver: UpdateReceiverType?
    let provider: MoyaProvider<MyService>
    
    init(provider: MoyaProvider<MyService> = MoyaProvider()) {
        self.provider = provider
        fetchPhotoURL()
    }
    
    fileprivate func fetchPhotoURL(from date: Date? = nil) {
        
        let dateString = date?.yyyyMMdd(withSeparator: "-") ?? Date().yyyyMMdd(withSeparator: "-")
        
        if urls[dateString] != nil {
            // url for this date is already cached
            return
        }
        
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

// MARK: - Helper Methods

extension APODPhotos {
    
    func photoURL(from date: Date) -> URL? {
        
        guard let url = urls[date.yyyyMMdd(withSeparator: "-")] else {
            fetchPhotoURL(from: date)
            return nil
        }
        
        return url
    }
    
    func photoURL(fromNumberOfDaysBeforeToday numberOfDaysBeforeToday: Int ) -> URL? {
        let date = Date().subtractingNumberOfDays(numberOfDaysBeforeToday)
        return photoURL(from: date)
    }
    
    func shiftOneDay(_ shift: DateShift) {
        
        // don't allow negative indices in numberOfDaysBeforeToday
        if shift == .forward && numberOfDaysBeforeToday.last == 0 { return }
        
        numberOfDaysBeforeToday = shift == .forward ? numberOfDaysBeforeToday.map { $0 - 1 } : numberOfDaysBeforeToday.map { $0 + 1 }
    }
}

extension Date {
    
    func subtractingNumberOfDays(_ days: Int) -> Date {
        let timeInterval = TimeInterval(-1 * days * 24 * 60 * 60)
        return self.addingTimeInterval(timeInterval)
    }
}
