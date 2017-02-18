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
    
    // Mark: - Layout
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
}
