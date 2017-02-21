//
//  ScrollViewCell.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/20/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class ScrollViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: self.frame)
        
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        contentView.addSubview(scrollView)
    }
}
