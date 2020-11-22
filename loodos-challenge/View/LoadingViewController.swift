//
//  LoadingViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import UIKit
class LoadingViewController: UIViewController {
    // MARK: - Views
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.transform = transform
        return activityIndicator
    }()

    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        //activityIndicator.frame = CGRect(x: (view.frame.size.width/2), y: view.frame.size.width/2, width: 0, height: 0 )
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.safeCenterXAnchor.constraint(equalTo: view.safeCenterXAnchor),
            activityIndicator.safeCenterYAnchor.constraint(equalTo: view.safeCenterYAnchor)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
    }
}
