//
//  RoverPhotoViewController.swift
//  NASApp
//
//  Created by Christopher Bonuel on 2/17/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI

class RoverPhotoViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var imageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.kf.setImage(with: self.photoURL)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // so textView can still receive taps
        imageView.isUserInteractionEnabled = true
        
       return imageView
    }()
    
    lazy var textView: UITextView = {
        
        let textView = UITextView()
        
        textView.backgroundColor = .clear
        
        textView.textColor = .white
        textView.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
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
        imageView.addSubview(textView)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            textView.topAnchor.constraint(equalTo: imageView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            textView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
        ])
    }
}

// MARK: - Helper Methods

extension RoverPhotoViewController {
    
    func makePostcard() -> Data? {
        
        textView.endEditing(true)
        
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, 0.0)
        
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        
        imageView.layer.render(in: currentContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        
        UIGraphicsEndImageContext()
        
        return UIImagePNGRepresentation(image)
    }
}

extension RoverPhotoViewController: MFMailComposeViewControllerDelegate {
    
    func composeEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self
            
            guard let png = makePostcard() else {
                presentAlert(title: "Error making postcard")
                return
            }
            
            mail.addAttachmentData(png, mimeType: "image/png", fileName: "NASApp.png")
            
            present(mail, animated: true)
            
        } else {
            
            presentAlert(title: "NASApp cannot send email", message: "Please check your email settings")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension UIViewController {
    
    func presentAlert(title: String?, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
