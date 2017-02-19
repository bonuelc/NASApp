//
//  MyService.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/5/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation
import Moya

private let api_key = "zlTZaHucX1ayYgkmRPCWjLpiTsny09pZHlHzP0HI"

extension Date {
    
    func yyyyMMdd(withSeparator separator: String = "") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy\(separator)MM\(separator)dd"
        return formatter.string(from: self)
    }
}

enum MyService {
    case apod(date: Date?)
    case curiosity
    case opportunity
    case spirit
}

extension MyService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.nasa.gov")!
    }
    
    var path: String {
        switch self {
        case .apod: return "/planetary/apod"
        case .curiosity: return "/mars-photos/api/v1/rovers/curiosity/photos"
        case .opportunity: return "/mars-photos/api/v1/rovers/opportunity/photos"
        case .spirit: return "/mars-photos/api/v1/rovers/spirit/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .apod(let date):
            var parameters = ["api_key":api_key]
            if let date = date {
                parameters["date"] = date.yyyyMMdd(withSeparator: "-")
            }
            return parameters
        case .curiosity, .opportunity, .spirit: return ["sol":"1000", "api_key":api_key]
        }
        
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .apod: return "{\"copyright\": \"Sebastian Voltmer\",\"date\": \"2017-01-01\",\"explanation\": \"Higher than the highest building, higher than the highest mountain, higher than the highest airplane, lies the realm of the aurora.  Auroras rarely reach below 60 kilometers, and can range up to 1000 kilometers. Aurora light results from energetic electrons and protons striking molecules in the Earth's atmosphere.  Frequently, when viewed from space, a complete aurora will appear as a circle around one of the Earth's magnetic poles.  The featured wide-angle image, horizontally compressed, captured an unexpected auroral display that stretched across the sky five years ago over eastern Norway.\",\"hdurl\": \"http://apod.nasa.gov/apod/image/1701/aurora_voltmer_1920.jpg\",\"media_type\": \"image\",\"service_version\": \"v1\",\"title\": \"A Full Sky Aurora Over Norway\",\"url\": \"http://apod.nasa.gov/apod/image/1701/aurora_voltmer_960.jpg\"}".utf8Encoded
        case .curiosity, .opportunity, .spirit: return "{\"photos\":[{\"id\":102693,\"sol\":1000,\"camera\":{\"id\":20,\"name\":\"FHAZ\",\"rover_id\":5,\"full_name\":\"Front Hazard Avoidance Camera\"},\"img_src\":\"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG\",\"earth_date\":\"2015-05-30\",\"rover\":{\"id\":5,\"name\":\"Curiosity\",\"landing_date\":\"2012-08-06\",\"launch_date\":\"2011-11-26\",\"status\":\"active\",\"max_sol\":1599,\"max_date\":\"2017-02-03\",\"total_photos\":300856,\"cameras\":[{\"name\":\"FHAZ\",\"full_name\":\"Front Hazard Avoidance Camera\"},{\"name\":\"NAVCAM\",\"full_name\":\"Navigation Camera\"},{\"name\":\"MAST\",\"full_name\":\"Mast Camera\"},{\"name\":\"CHEMCAM\",\"full_name\":\"Chemistry and Camera Complex\"},{\"name\":\"MAHLI\",\"full_name\":\"Mars Hand Lens Imager\"},{\"name\":\"MARDI\",\"full_name\":\"Mars Descent Imager\"},{\"name\":\"RHAZ\",\"full_name\":\"Rear Hazard Avoidance Camera\"}]}}]}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .apod, .curiosity, .opportunity, .spirit: return .request
        }
    }
}

private extension String {
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

