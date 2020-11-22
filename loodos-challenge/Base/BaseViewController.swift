//
//  BaseViewController.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import UIKit
import Network
class BaseViewController: UIViewController {
    // MARK: - Views
    private let loadingViewController = LoadingViewController()
    private(set) var monitor: Dynamic<NWPathMonitor> = Dynamic(NWPathMonitor()) //for internet connection
    private(set) var queue = DispatchQueue(label: "InternetConnectionMonitor")  //for internet connection
    func showLoadingView() {
        add(loadingViewController)
    }
    
    func removeLoadingView() {
        loadingViewController.remove()
    }
}
