//
//  PhotoCell.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/16/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    // MARK: - UI
    
    private let imageView: UIImageView
    
    // MARK: - Properties
    
    static var reuseIdentifier = "photoCell"
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
     
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.contentMode = .scaleAspectFit
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        contentView.addSubview(imageView)
    }
}
