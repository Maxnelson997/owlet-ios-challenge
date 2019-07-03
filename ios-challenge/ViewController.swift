//
//  ViewController.swift
//  ios-challenge
//
//  Created by Lorraine Alexander on 4/15/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet weak var countLabel: UILabel!
    
    fileprivate let loadAnImageButton: UIButton = {
       let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.layer.cornerRadius = 5
        b.backgroundColor = UIColor.init(red: 5/255, green: 123/255, blue: 252/252, alpha: 1)
        b.setTitle("Load An Image!", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)

        setupUI()
    }
    
    fileprivate func setupUI() {
        view.addSubview(loadAnImageButton)
        loadAnImageButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        loadAnImageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loadAnImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadAnImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        loadAnImageButton.addTarget(self, action: #selector(handleLoadAnImage), for: .touchUpInside)
    }
    
    @objc fileprivate func handleLoadAnImage() {
        let imageController = UnsplashImageController()
        present(imageController, animated: true)
    }
    
    func newState(state: State) {
        guard let state = store.state as? AppState else { return }
        let count = state.counter
        countLabel.text = String(count)
    }
    
    @IBAction func didTapIncreaseButton(_ sender: Any) {
        store.dispatch(action: IncreaseAction(increaseBy: 1))
    }
    
    @IBAction func didTapDecreaseButton(_ sender: Any) {
        store.dispatch(action: DecreaseAction(decreaseBy: 1))
    }
}

