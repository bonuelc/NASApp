//
//  LandingPage.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/24/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class LandingPage: UIView {
    
    // MARK: - UI
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
}
