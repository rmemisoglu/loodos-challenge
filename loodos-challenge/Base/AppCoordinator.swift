//
//  AppCoordinator.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import UIKit

class AppCoordinator: Coordinator {
    enum Identifier: String {
        case homeViewController = "HomeViewController"
    }
    
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    static func homeViewController() -> HomeViewController {
        return mainStoryboard().instantiateViewController(withIdentifier: Identifier.homeViewController.rawValue) as! HomeViewController
    }
    
}
