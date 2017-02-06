//
//  MyService.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/5/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import Foundation
import Moya

enum MyService {
    case curiosity
    case opportunity
    case spirit
}

extension MyService: TargetType {
}

