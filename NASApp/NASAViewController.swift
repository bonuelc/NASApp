//
//  NASAViewController.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/1/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import Kingfisher

protocol UpdateReceiverType {
    func didUpdateModel()
}

class NASAViewController: UIViewController, UpdateReceiverType {
    
    // MARK: - UI
    
    lazy var collectionView: UICollectionView = {
        
        var flowLayout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    let nasaViewModel: NASAViewModel
    
    // MARK: - Initializers
    
    init(nasaViewModel: NASAViewModel = NASAViewModel()) {
        
        self.nasaViewModel = nasaViewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.nasaViewModel.updateReceiver = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
    
        view.addSubview(collectionView)
    
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func didUpdateModel() {
        collectionView.reloadData()
    }
}

    // MARK: - UICollectionViewDataSource

extension NASAViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return nasaViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nasaViewModel.numberOfPhotos(inSection: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else { fatalError() }
        let url = nasaViewModel.photoURL(at: indexPath)
        
        return cell.configure(withImageFrom: url)
    }
}

// MARK: - UICollectionViewDelegate

extension NASAViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let url = nasaViewModel.photoURL(at: indexPath)
        let roverPhotoVC = RoverPhotoViewController(photoURL: url)

        show(roverPhotoVC, sender: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NASAViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = collectionView.bounds.size.width
        return CGSize(width: side, height: side)
    }
}
