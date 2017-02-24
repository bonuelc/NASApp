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
        
        // TODO: does it make sense to reuse this cell?
        collectionView.register(ScrollViewCell.self, forCellWithReuseIdentifier: ScrollViewCell.reuseIdentifier)
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

        guard let section = NASASection(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .astronomyPictureOfTheDay:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollViewCell.reuseIdentifier, for: indexPath) as? ScrollViewCell else { fatalError() }
            
            let scrollViewIndices = nasaViewModel.scrollViewIndices.map { IndexPath(row: $0, section: indexPath.section) }
            let urls = scrollViewIndices.map { nasaViewModel.photoURL(at: $0) }
            
            return cell.configure(withImagesFrom: urls)
            
        case .marsRoverImagery:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else { fatalError() }
            guard let url = nasaViewModel.photoURL(at: indexPath) else { return cell }
            
            return cell.configure(withImageFrom: url)
            
        default: fatalError()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension NASAViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let section = NASASection(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .marsRoverImagery:
            guard let url = nasaViewModel.photoURL(at: indexPath) else { fatalError() }
            let roverPhotoVC = RoverPhotoViewController(photoURL: url)
            
            show(roverPhotoVC, sender: nil)
        default: break
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NASAViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let side = collectionView.bounds.size.width
        return CGSize(width: side, height: side)
    }
}
