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
    
    lazy var topLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Welcome"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "to NASAPP"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    override func layoutSubviews() {
        
        addSubview(imageView)
        addSubview(topLabel)
        addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor),
            
            topLabel.centerYAnchor.constraint(equalTo: imageView.topAnchor, constant: -20),
            topLabel.leftAnchor.constraint(equalTo: leftAnchor),
            topLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            bottomLabel.centerYAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            bottomLabel.leftAnchor.constraint(equalTo: leftAnchor),
            bottomLabel.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

}
