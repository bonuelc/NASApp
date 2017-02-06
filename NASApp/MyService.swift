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

enum MyService {
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
        case .curiosity: return "/mars-photos/api/v1/rovers/curiosity/photos"
        case .opportunity: return "/mars-photos/api/v1/rovers/opportunity/photos"
        case .spirit: return "/mars-photos/api/v1/rovers/spirit/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var parameters: [String : Any]? {
        return ["sol":"1000", "api_key":api_key]
    }
}

