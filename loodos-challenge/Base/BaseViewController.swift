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
    
    func handleAlert(_ errorState: ErrorState){
        switch errorState {
            case .error(let message):
                showAlert(message)
        default:
            debugPrint("Default switch \(#function)")
        }
    }
    //show handling error
    func showAlert(_ message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("OK");
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

class BaseTableViewController: UITableViewController {
    // MARK: - Views
    private let loadingViewController = LoadingViewController()
    func showLoadingView() {
        add(loadingViewController)
    }
    
    func removeLoadingView() {
        loadingViewController.remove()
    }
    
    func handleAlert(_ errorState: ErrorState){
        switch errorState {
            case .error(let message):
                showAlert(message)
        default:
            debugPrint("Default switch \(#function)")
        }
    }
    //show handling error
    func showAlert(_ message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("OK");
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
