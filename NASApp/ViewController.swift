//
//  ViewController.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/1/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var collectionView: UICollectionView = {
        
        var flowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
}

