//
//  ScrollViewCell.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/20/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import Kingfisher

enum Page: Int {
    case left, center, right
}

class ScrollViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: self.frame)
        
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    // MARK: - Properties
    
    static var reuseIdentifier = "scrollViewCell"
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        contentView.addSubview(scrollView)
    }
}

// MARK: - Helper Methods

extension ScrollViewCell {
    
    func configure(withImagesFrom urls: [URL?], scrollTo page: Page = .center) -> ScrollViewCell {
        
        scrollView.removeSubviews()
        
        var contentWidthOfScrollView: CGFloat = 0
        
        for url in urls {
            
            let imageView = UIImageView()
            imageView.frame = CGRect(origin: CGPoint(x: contentWidthOfScrollView, y: 0), size: scrollView.bounds.size)
            imageView.contentMode = .scaleAspectFit
            if let url = url {
                imageView.kf.setImage(with: url)
            }
            
            scrollView.addSubview(imageView)
            contentWidthOfScrollView += imageView.bounds.size.width
        }
        
        scrollView.contentSize = CGSize(width: contentWidthOfScrollView, height: scrollView.bounds.size.height)
        
        scrollView.scroll(to: page)
        
        return self
    }
}

private extension UIScrollView {
    
    func scroll(to page: Page) {
        
        let size = self.bounds.size
        
        switch page {
        case .left: self.bounds = CGRect(origin: .zero, size: size)
        case .center: self.bounds = CGRect(origin: CGPoint(x: self.contentSize.width / 3, y: self.frame.minY), size: size)
        case .right: self.bounds = CGRect(origin: CGPoint(x: self.contentSize.width * 2 / 3, y: self.frame.minY), size: size)
        }
    }
}

extension UIView {
    
    func removeSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
