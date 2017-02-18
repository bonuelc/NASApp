//
//  RoverPhotoViewController.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/17/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import Kingfisher

class RoverPhotoViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.kf.setImage(with: self.photoURL)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
       return imageView
    }()
    
    // MARK: - Properties
    
    let photoURL: URL
    
    // MARK: - Initializers
    
    init(photoURL: URL) {
        
        self.photoURL = photoURL
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
