//
//  UnsplashImageController.swift
//  ios-challenge
//
//  Created by Max Nelson on 7/2/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

class UnsplashImageController: UIViewController {
    
    fileprivate let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    fileprivate let imageStringURL: String = "https://source.unsplash.com/user/maxcodes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        imageView.asyncLoadImage(from: imageStringURL)
    }
    
 
}



extension UIImageView {
    func asyncLoadImage(from urlString: String) {

        guard let url = URL(string: urlString) else {
            print("please provide a valid url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("error downloading image", err)
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { print("no data fetched"); return }
                let fetchedImage = UIImage(data: data)
                self.image = fetchedImage
            }
        }.resume()

    }
}
